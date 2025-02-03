import database from "../../Data/database.js"; // Modelo do MongoDB ou banco de dados usado.

const Messages = {
  sendMessage: async (req, res) => {
    try {
      const { senderId, receiverId, text } = req.body;

      if (!senderId || !receiverId || !text) {
        return res.status(400).json({ error: "Dados inválidos" });
      }

      const message = await database.create({
        senderId,
        receiverId,
        text,
        timestamp: new Date(),
      });

      return res.status(200).json({ success: true, message });
    } catch (error) {
      console.error("Erro ao enviar mensagem:", error);
      return res.status(500).json({ success: false, error: "Erro interno do servidor" });
    }
  },

  getMessages: async (req, res) => {
    try {
      const { senderId, receiverId } = req.query;

      if (!senderId || !receiverId) {
        return res.status(400).json({ error: "Dados inválidos" });
      }

      const messages = await database.find({
        $or: [
          { senderId, receiverId },
          { senderId: receiverId, receiverId: senderId },
        ],
      }).sort({ timestamp: 1 });

      return res.status(200).json({ success: true, messages });
    } catch (error) {
      console.error("Erro ao buscar mensagens:", error);
      return res.status(500).json({ success: false, error: "Erro interno do servidor" });
    }
  },
};

export default Messages;
