const Product = require('../models/Product');

exports.getAllProducts = async (req, res) => {
  try {
    const produtos = await Product.find();
    res.json(produtos);
  } catch (error) {
    res.status(500).json({ message: 'Erro ao buscar produtos', error: error.message });
  }
};

exports.getProductById = async (req, res) => {
  try {
    const produto = await Product.findById(req.params.id);
    if (!produto) {
      return res.status(404).json({ message: 'Produto não encontrado' });
    }
    res.json(produto);
  } catch (error) {
    res.status(500).json({ message: 'Erro ao buscar produto', error: error.message });
  }
};

exports.createProduct = async (req, res) => {
  try {
    const { nome, descricao, preco, imagem, categoria, estoque } = req.body;

    if (!nome || !descricao || !preco || !imagem) {
      return res.status(400).json({ message: 'Campos obrigatórios não preenchidos' });
    }

    const novoProduto = await Product.create({
      nome,
      descricao,
      preco,
      imagem,
      categoria,
      estoque,
    });

    res.status(201).json(novoProduto);
  } catch (error) {
    res.status(500).json({ message: 'Erro ao criar produto', error: error.message });
  }
};

exports.updateProduct = async (req, res) => {
  try {
    const { nome, descricao, preco, imagem, categoria, estoque } = req.body;

    const produtoAtualizado = await Product.findByIdAndUpdate(
      req.params.id,
      { nome, descricao, preco, imagem, categoria, estoque },
      { new: true }
    );

    if (!produtoAtualizado) {
      return res.status(404).json({ message: 'Produto não encontrado' });
    }

    res.json(produtoAtualizado);
  } catch (error) {
    res.status(500).json({ message: 'Erro ao atualizar produto', error: error.message });
  }
};

exports.deleteProduct = async (req, res) => {
  try {
    const produto = await Product.findByIdAndDelete(req.params.id);

    if (!produto) {
      return res.status(404).json({ message: 'Produto não encontrado' });
    }

    res.json({ message: 'Produto deletado com sucesso' });
  } catch (error) {
    res.status(500).json({ message: 'Erro ao deletar produto', error: error.message });
  }
};

exports.setPromotion = async (req, res) => {
  try {
    const produto = await Product.findByIdAndUpdate(
      req.params.id,
      { promocao: true },
      { new: true }
    );

    if (!produto) {
      return res.status(404).json({ message: 'Produto não encontrado' });
    }

    res.json({ message: 'Produto marcado como promoção', produto });
  } catch (error) {
    res.status(500).json({ message: 'Erro ao marcar promoção', error: error.message });
  }
};

exports.removePromotion = async (req, res) => {
  try {
    const produto = await Product.findByIdAndUpdate(
      req.params.id,
      { promocao: false },
      { new: true }
    );

    if (!produto) {
      return res.status(404).json({ message: 'Produto não encontrado' });
    }

    res.json({ message: 'Promoção removida do produto', produto });
  } catch (error) {
    res.status(500).json({ message: 'Erro ao remover promoção', error: error.message });
  }
};

exports.getPromotions = async (req, res) => {
  try {
    const produtos = await Product.find({ promocao: true });
    res.json(produtos);
  } catch (error) {
    res.status(500).json({ message: 'Erro ao buscar promoções', error: error.message });
  }
};
