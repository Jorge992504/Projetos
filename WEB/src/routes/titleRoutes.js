import { Router } from 'express';
import { createTitle, getTitles, getTitlesByClient } from '../controller/titleController.js';

const router = Router();

router.post('/', createTitle);
router.get('/', getTitles);
router.get('/client/:clientId', getTitlesByClient);

export default router;
