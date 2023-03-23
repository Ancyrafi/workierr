const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.deleteExpiredOrders = functions.pubsub
    .schedule("every 2 minutes")
    .onRun(async (context) => {
      const usersRef = admin.firestore().collection("users");
      const usersSnapshot = await usersRef.get();

      const now = Date.now();
      console.log("Bieżący czas:", now);

      console.log("Liczba użytkowników:", usersSnapshot.size);

      usersSnapshot.forEach(async (userDoc) => {
        console.log("Sprawdzanie użytkownika:", userDoc.id);
        const itemsRef = userDoc.ref.collection("items");
        const itemsSnapshot = await itemsRef
            .where("deleteTimestamp", "<", now)
            .get();

        console.log(
            `Znaleziono ${itemsSnapshot.size}` +
          ` dokumentów do usunięcia dla użytkownika ${userDoc.id}`,
        );

        itemsSnapshot.forEach(async (itemDoc) => {
          const itemData = itemDoc.data();
          console.log(
              "Usuwanie zlecenia o ID:",
              itemDoc.id,
              "z deleteTimestamp:",
              itemData.deleteTimestamp,
              "i obecny czas:",
              now,
          );
          await itemDoc.ref.delete();
          console.log("Usunięto zlecenie o ID:", itemDoc.id);
        });
      });
    });
