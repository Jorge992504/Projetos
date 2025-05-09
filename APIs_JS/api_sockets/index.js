require("dotenv").config();
const WebSocket = require("ws");

const wss = new WebSocket.Server({
    port: process.env.port
});

function onConnection(params) {
    console.log("onConnection");
}


wss.on("connection", onConnection);
console.log(`WebSocket Server is running at ${process.env.port}`);