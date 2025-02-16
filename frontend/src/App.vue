<script setup lang="ts">
import { ref, onMounted } from "vue";

const message = ref("");

onMounted(async () => {
  try {
    const response = await fetch("http://localhost:8080/api/test");
    if (!response.ok)
      throw new Error("Erreur lors de la récupération des données");

    message.value = await response.text();
  } catch (error) {
    console.error("Erreur API:", error);
    message.value = "Erreur de connexion au backend";
  }
});
</script>

<template>
  <div>
    <h1>Bienvenue sur CodeSwap</h1>
    <p>Réponse du backend : {{ message }}</p>
  </div>
</template>
