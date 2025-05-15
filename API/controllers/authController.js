const User = require('../models/User');
const jwt = require('jsonwebtoken');

const gerarToken = (userId) => {
  return jwt.sign({ id: userId }, process.env.JWT_SECRET, { expiresIn: '30d' });
};

exports.register = async (req, res) => {
  try {
    const { nome, email, senha, telefone, endereco, nascimento } = req.body;

    if (!nome || !email || !senha) {
      return res.status(400).json({ message: 'Nome, email e senha são obrigatórios' });
    }

    const userExists = await User.findOne({ email });
    if (userExists) {
      return res.status(400).json({ message: 'Email já cadastrado' });
    }

    const user = await User.create({ nome, email, senha, telefone, endereco, nascimento });

    res.status(201).json({
      _id: user._id,
      nome: user.nome,
      email: user.email,
      token: gerarToken(user._id),
    });
  } catch (error) {
    res.status(500).json({ message: 'Erro ao registrar usuário', error: error.message });
  }
};

exports.login = async (req, res) => {
  try {
    const { email, senha } = req.body;

    const user = await User.findOne({ email });
    if (!user || !(await user.comparePassword(senha))) {
      return res.status(401).json({ message: 'Credenciais inválidas' });
    }

    res.json({
      _id: user._id,
      nome: user.nome,
      email: user.email,
      token: gerarToken(user._id),
    });
  } catch (error) {
    res.status(500).json({ message: 'Erro ao fazer login', error: error.message });
  }
};

exports.forgotPassword = async (req, res) => {
  try {
    const { email } = req.body;

    const user = await User.findOne({ email });
    if (!user) return res.status(404).json({ message: 'Usuário não encontrado' });

    const resetToken = jwt.sign({ id: user._id }, process.env.JWT_SECRET, { expiresIn: '1h' });

    res.json({ message: 'Token de redefinição gerado', resetToken });
  } catch (error) {
    res.status(500).json({ message: 'Erro ao processar solicitação', error: error.message });
  }
};

exports.resetPassword = async (req, res) => {
  try {
    const { token, novaSenha } = req.body;

    if (!token || !novaSenha) {
      return res.status(400).json({ message: 'Token e nova senha são obrigatórios' });
    }

    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const user = await User.findById(decoded.id);

    if (!user) return res.status(404).json({ message: 'Usuário não encontrado' });

    user.senha = novaSenha;
    await user.save();

    res.json({ message: 'Senha redefinida com sucesso' });
  } catch (error) {
    res.status(500).json({ message: 'Erro ao redefinir senha', error: error.message });
  }
};
