import express, { Request, Response } from "express"; // NE PAS importer `Application`

const app = express(); // PAS besoin de typage Application ici
app.use(express.json());

app.post("/compute", (req: Request, res: Response) => {
  console.log("Requête reçue :", req.body);
  const { data } = req.body;
  if (!data) {
    return res.status(400).json({ error: "Donnée manquante" });
  }
  const result = data.toUpperCase();
  res.json({ result });
});

const PORT = parseInt(process.env.PORT || "5000", 10);
app.listen(PORT, "0.0.0.0", () =>
  console.log(`✅ Logic service running on port ${PORT}`)
);
