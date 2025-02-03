import { WebSocketServer } from 'ws';

function onError(ws, err) {
    console.error(`onError: ${err.message}`);
}

function onMessage(ws, data) {
    console.log(`onMessage: ${data}`);
    ws.send(`recebido!`);
}

function onConnection(ws, req) {
    ws.on('message', data => onMessage(ws, data));
    ws.on('error', error => onError(ws, error));
    console.log(`onConnection`);
}



export default () => {
    const wss = new WebSocketServer({
        port: 3002
    });

    wss.on('connection', onConnection);
    wss.on('disconnect', () => console.log("disconnect"));
    wss.on('message', onMessage);

    console.log(`App Web Socket Server is running!`);
    return wss;
}