const Order = require('../models/Order');
const Cart = require('../models/Cart');
const Product = require('../models/Product');

exports.createOrder = async (req, res) => {
  try {
    const { enderecoEntrega, metodoPagamento } = req.body;

    const cart = await Cart.findOne({ usuario: req.user.id }).populate('itens.produto');
    if (!cart || cart.itens.length === 0) {
      return res.status(400).json({ message: 'Carrinho vazio' });
    }

    const orderItems = [];
    let total = 0;

    for (const item of cart.itens) {
      const product = await Product.findById(item.produto._id);
      if (product.estoque < item.quantidade) {
        return res.status(400).json({ message: `Sem estoque para ${product.nome}` });
      }

      orderItems.push({
        produto: product._id,
        quantidade: item.quantidade,
        precoUnitario: product.preco,
      });

      product.estoque -= item.quantidade;
      await product.save();
      total += product.preco * item.quantidade;
    }

    const order = await Order.create({
      usuario: req.user.id,
      itens: orderItems,
      total,
      enderecoEntrega,
      metodoPagamento,
    });

    await Cart.findOneAndUpdate({ usuario: req.user.id }, { itens: [] });

    res.status(201).json(order);
  } catch (error) {
    res.status(500).json({ message: 'Erro ao criar pedido', error: error.message });
  }
};

exports.getUserOrders = async (req, res) => {
  try {
    const orders = await Order.find({ usuario: req.user.id })
      .populate('itens.produto')
      .sort({ dataPedido: -1 });

    res.json(orders);
  } catch (error) {
    res.status(500).json({ message: 'Erro ao buscar pedidos', error: error.message });
  }
};

exports.getOrderDetails = async (req, res) => {
  try {
    const order = await Order.findById(req.params.id)
      .populate('itens.produto')
      .populate('usuario', 'nome email');

    if (!order) return res.status(404).json({ message: 'Pedido não encontrado' });

    const isOwner = order.usuario._id.toString() === req.user.id;
    if (!isOwner && !req.user.isAdmin) {
      return res.status(403).json({ message: 'Acesso negado' });
    }

    res.json(order);
  } catch (error) {
    res.status(500).json({ message: 'Erro ao buscar pedido', error: error.message });
  }
};

exports.updateOrderStatus = async (req, res) => {
  try {
    const { status } = req.body;

    const order = await Order.findByIdAndUpdate(
      req.params.id,
      { status },
      { new: true }
    ).populate('itens.produto');

    if (!order) return res.status(404).json({ message: 'Pedido não encontrado' });

    res.json(order);
  } catch (error) {
    res.status(500).json({ message: 'Erro ao atualizar status', error: error.message });
  }
};

exports.getAllOrders = async (req, res) => {
  try {
    const orders = await Order.find()
      .populate('itens.produto')
      .populate('usuario', 'nome email')
      .sort({ dataPedido: -1 });

    res.json(orders);
  } catch (error) {
    res.status(500).json({ message: 'Erro ao buscar pedidos', error: error.message });
  }
};

exports.approveOrder = async (req, res) => {
  try {
    const order = await Order.findById(req.params.id).populate('itens.produto');
    if (!order) return res.status(404).json({ message: 'Pedido não encontrado' });

    if (order.status !== 'pendente') {
      return res.status(400).json({ message: 'Pedido já foi processado' });
    }

    const { paymentConfirmed } = req.body;
    if (!paymentConfirmed) {
      return res.status(400).json({ message: 'Pagamento não confirmado' });
    }

    for (const item of order.itens) {
      if (item.produto.estoque < item.quantidade) {
        return res.status(400).json({ message: `Estoque insuficiente para ${item.produto.nome}` });
      }
    }

    for (const item of order.itens) {
      const product = await Product.findById(item.produto._id);
      product.estoque -= item.quantidade;
      await product.save();
    }

    order.status = 'pago';
    await order.save();

    res.json(order);
  } catch (error) {
    res.status(500).json({ message: 'Erro ao aprovar pedido', error: error.message });
  }
};
