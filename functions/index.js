const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.deleteExpiredOrders = functions.pubsub
    .schedule("every 2 minutes")
    .onRun(async (context) => {
      try {
        const itemsRef = admin.firestore().collectionGroup("items");
        const now = Date.now();
        console.log("Bieżący czas:", now);

        const itemsSnapshot = await itemsRef
            .where("deleteTimestamp", "<", now)
            .get();

        console.log(
            `Znaleziono ${itemsSnapshot.size} dokumentów do usunięcia`,
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
      } catch (error) {
        console.error("Wystąpił błąd podczas usuwania zleceń:", error);
      }
    });
