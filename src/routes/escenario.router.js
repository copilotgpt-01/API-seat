const express = require("express");
const router = express.Router();
const pool = require("../config/db");

router.get("/", async (req, res) => {
  try {
    const [escenarios] = await pool.query("SELECT * FROM Escenario");
    const escenariosConAsientos = await Promise.all(
      escenarios.map(async (escenario) => {
        const asientos = await getAsientosPorEscenarioId(
          escenario.escenario_id
        );
        return { ...escenario, asientos };
      })
    );
    res.json(escenariosConAsientos);
  } catch (error) {
    manejarError(res, error);
  }
});

router.get("/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const escenario = await getEscenarioPorId(id);
    const asientos = await getAsientosPorEscenarioId(id);
    const escenarioConAsientos = { ...escenario, asientos };
    res.json(escenarioConAsientos);
  } catch (error) {
    manejarError(res, error);
  }
});

router.post("/", async (req, res) => {
  const { asiento, forma, evento_id } = req.body;
  if (!asiento || !forma || !evento_id) {
    return res.status(400).json({ error: "Faltan campos obligatorios" });
  }
  try {
    validarForma(forma);
    await validarEvento(evento_id);

    const [rows] = await pool.query(
      "INSERT INTO Escenario (asiento, forma, evento_id) VALUES (?, ?, ?)",
      [asiento, forma, evento_id]
    );
    const escenarioId = rows.insertId;

    // Crea los Asientos para el Escenario
    for (let i = 1; i <= asiento; i++) {
      await pool.query(
        "INSERT INTO Asientos (numero_asiento, estado, usuario_id) VALUES (?, 'Disponible', NULL)",
        [`${escenarioId}-${i}`]
      );
    }

    res.json({
      message: "Escenario y asientos creados exitosamente",
      escenario_id: escenarioId,
      asiento,
      forma,
      evento_id,
    });
  } catch (error) {
    manejarError(res, error);
  }
});

router.delete("/:id", async (req, res) => {
  const { id } = req.params;
  try {
    await getEscenarioPorId(id);

    await pool.query("DELETE FROM Asientos WHERE numero_asiento LIKE ?", [
      `${id}-%`,
    ]);
    await pool.query("DELETE FROM Escenario WHERE escenario_id = ?", [id]);

    res.json({ message: "Escenario y asientos eliminados exitosamente" });
  } catch (error) {
    manejarError(res, error);
  }
});

router.put("/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const escenario = await getEscenarioPorId(id);

    if (req.body.asiento) {
      return res
        .status(400)
        .json({ error: "No se puede modificar el número de asientos" });
    }

    const forma = req.body.forma || escenario.forma;
    if (req.body.forma) {
      validarForma(req.body.forma);
    }
    const evento_id = req.body.evento_id || escenario.evento_id;
    if (req.body.evento_id) {
      await validarEvento(req.body.evento_id);
    }
    const [result] = await pool.query(
      "UPDATE Escenario SET forma = ?, evento_id = ? WHERE escenario_id = ?",
      [forma, evento_id, id]
    );
    if (result.affectedRows > 0) {
      const updatedEscenario = await getEscenarioPorId(id);
      res.status(200).json({
        message: "Escenario actualizado exitosamente",
        escenario: updatedEscenario,
      });
    } else {
      res.status(400).json({ error: "No se pudo actualizar el escenario" });
    }
  } catch (error) {
    manejarError(res, error);
  }
});



// Funciones auxiliares

// Función para obtener asientos por escenario_id
const getAsientosPorEscenarioId = async (escenario_id) => {
  const [asientos] = await pool.query(
    "SELECT * FROM Asientos WHERE numero_asiento LIKE ?",
    [`${escenario_id}-%`]
  );
  return asientos;
};

// Función para obtener escenario por id
const getEscenarioPorId = async (id) => {
  const [escenarios] = await pool.query(
    "SELECT * FROM Escenario WHERE escenario_id = ?",
    [id]
  );
  if (escenarios.length === 0) {
    throw new Error("Escenario no encontrado");
  }
  return escenarios[0];
};

// Función para validar forma
const validarForma = (forma) => {
  const formasValidas = ["Redondo", "Cuadrado", "Triangular"];
  if (!formasValidas.includes(forma)) {
    throw new Error(
      `Forma no válida. Formas válidas: ${formasValidas.join(", ")}`
    );
  }
};

// Función para validar evento
const validarEvento = async (evento_id) => {
  const [eventos] = await pool.query(
    "SELECT * FROM Eventos WHERE evento_id = ?",
    [evento_id]
  );
  if (eventos.length === 0) {
    throw new Error(`Evento con el id ${evento_id} no encontrado`);
  }
};

// Función para manejar errores
const manejarError = (res, error) => {
  console.error(error);
  res.status(500).send({
    message: error.message,
  });
};

module.exports = router;
