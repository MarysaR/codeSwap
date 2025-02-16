import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";

// https://vite.dev/config/
export default defineConfig({
  plugins: [vue()],
  server: {
    port: 3000, // Port à utiliser (déjà mappé dans Docker)
    host: "0.0.0.0", // Expose le serveur à l'extérieur du conteneur Docker
  },
});
