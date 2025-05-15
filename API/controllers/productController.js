const Product = require('../models/Product');

exports.getAllProducts = async (req, res) => {
  try {
    const products = await Product.find();
    res.json(products);
  } catch (error) {
    res.status(500).json({ message: 'Erro ao buscar produtos', error: error.message });
  }
};

exports.getProductById = async (req, res) => {
  try {
    const product = await Product.findById(req.params.id);
    if (!product) {
      return res.status(404).json({ message: 'Produto não encontrado' });
    }
    res.json(product);
  } catch (error) {
    res.status(500).json({ message: 'Erro ao buscar produto', error: error.message });
  }
};

exports.createProduct = async (req, res) => {
  try {
    const { nome, descricao, preco, imagem, categoria, estoque } = req.body;
    const product = new Product({
      nome,
      descricao,
      preco,
      imagem,
      categoria,
      estoque,
    });
    await product.save();
    res.status(201).json(product);
  } catch (error) {
    res.status(500).json({ message: 'Erro ao criar produto', error: error.message });
  }
};

exports.updateProduct = async (req, res) => {
  try {
    const { nome, descricao, preco, imagem, categoria, estoque } = req.body;
    const product = await Product.findByIdAndUpdate(
      req.params.id,
      { nome, descricao, preco, imagem, categoria, estoque },
      { new: true }
    );
    if (!product) {
      return res.status(404).json({ message: 'Produto não encontrado' });
    }
    res.json(product);
  } catch (error) {
    res.status(500).json({ message: 'Erro ao atualizar produto', error: error.message });
  }
};

exports.deleteProduct = async (req, res) => {
  try {
    const product = await Product.findByIdAndDelete(req.params.id);
    if (!product) {
      return res.status(404).json({ message: 'Produto não encontrado' });
    }
    res.json({ message: 'Produto deletado com sucesso' });
  } catch (error) {
    res.status(500).json({ message: 'Erro ao deletar produto', error: error.message });
  }
};

exports.setPromotion = async (req, res) => {
  try {
    const product = await Product.findByIdAndUpdate(
      req.params.id,
      { promocao: true },
      { new: true }
    );
    if (!product) {
      return res.status(404).json({ message: 'Produto não encontrado' });
    }
    res.json({ message: 'Produto marcado como promoção', produto: product });
  } catch (error) {
    res.status(500).json({ message: 'Erro ao marcar promoção', error: error.message });
  }
};

exports.removePromotion = async (req, res) => {
  try {
    const product = await Product.findByIdAndUpdate(
      req.params.id,
      { promocao: false },
      { new: true }
    );
    if (!product) {
      return res.status(404).json({ message: 'Produto não encontrado' });
    }
    res.json({ message: 'Promoção removida do produto', produto: product });
  } catch (error) {
    res.status(500).json({ message: 'Erro ao remover promoção', error: error.message });
  }
};

exports.getPromotions = async (req, res) => {
  try {
    const produtosPromocao = await Product.find({ promocao: true });
    res.json(produtosPromocao);
  } catch (error) {
    res.status(500).json({ message: 'Erro ao buscar promoções', error: error.message });
  }
};
