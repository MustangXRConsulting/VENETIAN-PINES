const app = require('express')();
const http = require('http').createServer(app);
const request = require('request');
const redis = require("redis");
const db = redis.createClient(6379, "66.29.130.252");
//Socket Logic
const io = require('socket.io')(http);

app.get('/', (req, res) => {
    res.send("Yes server is working....");
});

function notify(cid,msg){
    var url="http://newmatrix.global/notify.php?cid="+cid+"&msg="+msg;
    console.log("url = " + url);

    request(url, { json: true }, (err, res, body) => {});
}

io.sockets.on('connection', function(socket){
  console.log("Query: ", socket.handshake.query);

  function handleMessage(data, eventName, room = false, cache = false, io = false, all = false) {
    const scObj = io ? io.sockets : socket;
    const finalObject = room ? scObj.to(data.to_id) : scObj;
    
    data.datetime = new Date().getTime() + "";
    //data.id = new Date().getTime() + "";
    data.read = 0;

    cache && cacheUserData(data.to_id ,data);

    if (all) {
      io.sockets.emit(eventName, data);
    } else {
      finalObject.emit(eventName, data);
    }

    socket.emit("sent", {...data, read: 1});
    
    if (!data.type) data.type = "1";
    const notifyData = {id: data.id, type: data.type, messageCount: 1};

    notify(data.to_id, JSON.stringify(notifyData));
  }

  socket.on('joinRoom', function(userId) {
    console.log("connection request form " + userId);
    socket.userId = userId;
    socket.join(userId);

    getCacheUserData(userId, handleMessage);
    setUserStatus(userId, 1);

    io.sockets.emit('registerResponse', {status:'success', userId});
  });

  socket.on('onReceived', function(d){
    const data = JSON.parse(d);

    // ping to user first;
    socket.emit("sent_" + data.from_id, {...data, read: 1});
    
    deleteUserCache(userId + data.id);
  });

  //*********************************---One_to_One_Chat---****************************************//
  socket.on('sendMessage', function(d){
    const data = JSON.parse(d);

    handleMessage(data, 'receiveMessage', true, true);
  });
  // start typing
  socket.on('startTyping', function(d){
    const data = JSON.parse(d);
    console.log(data.to_id + " has start typing");

    handleMessage(data, 'typing', true);
  });

  // end typing
  socket.on('endTyping', function(d){
    const data = JSON.parse(d);

    handleMessage(data, 'notTyping', true);
  });

  // block
  socket.on('block', function(d){
    const data = JSON.parse(d);
    data.type="26";
    
    handleMessage({...data, to_id: data.uid}, 'block', true);
  });

  // chat read
  socket.on('readChat', function(d) {
    const data = JSON.parse(d);

    handleMessage(data, 'markAsRead', true);
  });

  // delete msg
  socket.on('delMsg', function(d){
    const data = JSON.parse(d);
    data.type="5";

    handleMessage(data, 'msgDel', true);
  });

  // ping for reply
  socket.on('pingForReply', function(d){
    const data = JSON.parse(d);
    data.type = "2";

    handleMessage(data, 'replyPing', true);
  });

  //*********************************---Group_Chat---****************************************//
    socket.on('sendGroupMessage', function(d){
      const data = JSON.parse(d);
      data.type = "20"; // chat data msg
      const grpUsrs = data.to_ids;

      for (let i = 0; i < grpUsrs.length; i++) {
        handleMessage({...data, to_id: grpUsrs[i]}, 'receiveGroupMessage', true, true);

        data.read = 1;
        socket.to(data.from_id).emit('sentGroupMessage', data); // to sender
      }
    });

    // start group typing
    socket.on('startTypingGroup', function(d){
      const data = JSON.parse(d)
      var grpUsrs = data.to_ids;

      for(var i=0;i<grpUsrs.length;i++){
        handleMessage({...data, to_id: grpUsrs[i]}, 'typingGroup', true);
      }
    });

    // end group typing
    socket.on('endTypingGroup', function(d){
      const data = JSON.parse(d);
      var grpUsrs = data.to_ids;

      for(var i=0;i<grpUsrs.length;i++){
        handleMessage({...data, to_id: grpUsrs[i]}, 'notTypingGroup', true);
      }
    });
    // group updates
    socket.on('groupsUpdated', function(d){
      const data = JSON.parse(d);
      var grpUsrs=data.to_ids;
      for(var i=0;i<grpUsrs.length;i++){
        handleMessage({...data, to_id: grpUsrs[i]}, 'groupUpdates', true);
      }
    });
    // delete msg
    socket.on('groupDel', function(d){
      const data = JSON.parse(d);
      var grpUsrs=data.to_ids;
      
      for(var i=0;i<grpUsrs.length;i++){
        data.type="25";
        handleMessage({...data, to_id: grpUsrs[i]}, 'delGroup', true);
      }
    });

    // disconnect
    socket.on('disconnect',function(){
      console.log('disConnect:' + socket.userId);
      setUserStatus(socket.userId, 0);
    });
      
    //alias update
    socket.on('aliasUpdate',function(d){
        const data = JSON.parse(d);
        var grpUsrs=data.to_ids;
        
        for(var i=0;i<grpUsrs.length;i++){
          data.type = "27";
          handleMessage({...data, to_id: grpUsrs[i]}, 'aliasUpdate', true);
        }
    });

});

function dbSet(key, value) {
  return db.set(key, value);
}

function dbGet(key) {
  return db.get(key);
}

function deleteUserCache(key) {
  return db.del(key);
}

function getUserStatus(userId) {
  return dbGet(`user_${userId}`)
}

function setUserStatus(userId, status) {
  return dbSet(`user_${userId}`, status)
}

function cacheUserData(userId, data) {
  return dbSet(`${userId}:${data.id}`, JSON.stringify(data));
}

function getCacheUserData(userId, callback) {
  db.keys(userId + ':*', function (err, keys) {
    if (err) return console.log(err);

    for(var i = 0, len = keys.length; i < len; i++) {
      const data = dbGet(keys[i]);
      data && callback(JSON.parse(data), 'receiveMessage', true);
    }
});
}

http.listen(3000);











