const express = require("express");
const router = express.Router();
const pool = require("../config/db");

// Read all
router.get("/", async (req, res) => {
  try {
    const [rows, fields] = await pool.query("SELECT * FROM Escenario");
    res.json(rows);
  } catch (error) {
    console.error(error);
  }
});

router.get("/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const [rows, fields] = await pool.query(
      "SELECT * FROM Escenario WHERE escenario_id = ?",
      [id]
    );
    if (rows.length === 0) {
      return res.status(404).json({ error: "Escenario no encontrado" });
    }
    res.json(rows[0]);
  } catch (error) {
    console.error(error);
  }
});

// Create
router.post("/", async (req, res) => {
  const { asiento, forma, evento_id } = req.body;
  if (!asiento || !forma || !evento_id) {
    return res.status(400).send("Faltan campos obligatorios");
  }
  if (forma !== "Redondo" && forma !== "Cuadrado" && forma !== "Triangular") {
    return res.status(400).json({
      error: "Forma no válida",
      formasValidas: ["Redondo", "Cuadrado", "Triangular"],
    });
  }
  try {
    const [eventos] = await pool.query(
      "SELECT * FROM Eventos WHERE evento_id = ?",
      [evento_id]
    );
    if (eventos.length === 0) {
      return res
        .status(404)
        .json({ error: `Evento con el id ${evento_id} no encontrado` });
    }
    const [rows, fields] = await pool.query(
      "INSERT INTO Escenario (asiento, forma, evento_id) VALUES (?, ?, ?)",
      [asiento, forma, evento_id]
    );
    res.json({
      message: "Escenario creado exitosamente",
      escenario_id: rows.insertId,
      asiento,
      forma,
      evento_id,
    });
  } catch (error) {
    console.error(error);
  }
});

// Update

router.put("/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const [escenarios] = await pool.query(
      "SELECT * FROM Escenario WHERE escenario_id = ?",
      [id]
    );

    if (escenarios.length === 0) {
      return res.status(404).json({ error: "Escenario no encontrado" });
    }

    const escenario = escenarios[0];
    const asiento = req.body.asiento || escenario.asiento;

    let forma = undefined;
    if (req.body.forma) {
      if (
        req.body.forma !== "Redondo" &&
        req.body.forma !== "Cuadrado" &&
        req.body.forma !== "Triangular"
      ) {
        return res.status(400).json({
          error: "Forma no válida",
          formasValidas: ["Redondo", "Cuadrado", "Triangular"],
        });
      }
      forma = req.body.forma;
    } else {
      forma = escenario.forma;
    }

    let evento_id = undefined;

    if (req.body.evento_id) {
      evento_id = req.body.evento_id;
      const [eventos] = await pool.query(
        "SELECT * FROM Eventos WHERE evento_id = ?",
        [evento_id]
      );
      if (eventos.length === 0) {
        return res
          .status(404)
          .json({ error: `Evento con el id ${evento_id} no encontrado` });
      }
    } else {
      evento_id = escenario.evento_id;
    }
    const values = [asiento, forma, evento_id];

    const [result] = await pool.query(
      "UPDATE Escenario SET asiento = ?, forma = ?, evento_id = ? WHERE escenario_id = ?",
      [...values, id]
    );

    if (result.affectedRows > 0) {
      const [updatedEscenarios] = await pool.query(
        "SELECT * FROM Escenario WHERE escenario_id = ?",
        [id]
      );
      const updatedEscenario = updatedEscenarios[0];

      res.status(200).json({
        message: "Escenario actualizado exitosamente",
        escenario: updatedEscenario,
      });
    } else {
      res.status(400).json({ error: "No se pudo actualizar el escenario" });
    }
  } catch (error) {
    console.error(error);
  }
});

router.delete("/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const [escenarios] = await pool.query(
      "SELECT * FROM Escenario WHERE escenario_id = ?",
      [id]
    );
    if (escenarios.length === 0) {
      return res.status(404).json({ error: "Escenario no encontrado" });
    }
    const [rows, fields] = await pool.query(
      "DELETE FROM Escenario WHERE escenario_id = ?",
      [id]
    );
    res.json({ message: "Escenario eliminado exitosamente" });
  } catch (error) {
    console.error(error);
  }
});

module.exports = router;
