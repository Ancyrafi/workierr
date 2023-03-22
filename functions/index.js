const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

exports.deleteExpiredOrders = functions.pubsub
  .schedule('every 2 minutes')
  .onRun(async (context) => {
    const usersRef = admin.firestore().collection('users');
    const usersSnapshot = await usersRef.get();

    const now = Date.now();

    usersSnapshot.forEach(async (userDoc) => {
      const itemsRef = userDoc.ref.collection('items');
      const itemsSnapshot = await itemsRef.get();

      itemsSnapshot.forEach(async (itemDoc) => {
        const itemData = itemDoc.data();
        if (itemData.deleteTimestamp <= now) {
          await itemDoc.ref.delete();
          console.log('Usunięto zlecenie o ID:', itemDoc.id);
        }
      });
    });
  });
