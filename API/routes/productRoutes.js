const express = require('express');
const router = express.Router();
const productController = require('../controllers/productController');
const authMiddleware = require('../middlewares/authMiddleware');

router.get('/', productController.getAllProducts);
router.get('/:id', productController.getProductById);

router.post('/', authMiddleware.authenticate, authMiddleware.isAdmin, productController.createProduct);
router.put('/:id', authMiddleware.authenticate, authMiddleware.isAdmin, productController.updateProduct);
router.delete('/:id', authMiddleware.authenticate, authMiddleware.isAdmin, productController.deleteProduct);

router.get('/promocoes', productController.getPromotions);
router.patch('/:id/promocao', productController.setPromotion);
router.patch('/:id/remover-promocao', productController.removePromotion);

module.exports = router;