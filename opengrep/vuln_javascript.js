// Express handlers for the demo dashboard.
const express = require("express");
const { exec, execSync } = require("child_process");

const app = express();
app.use(express.json());

app.get("/dashboard/render", (req, res) => {
  const message = req.query.message || "";
  const container = document.getElementById("notice");
  container.innerHTML = "<p>" + message + "</p>";
  res.send("ok");
});

app.get("/profile/bio", (req, res) => {
  const bio = req.query.bio || "";
  const target = document.querySelector("#bio");
  target.innerHTML = bio;
  res.send("ok");
});

app.post("/calc/run", (req, res) => {
  const expression = req.body.expression || "0";
  const result = eval(expression);
  res.json({ result });
});

app.post("/scripts/run", (req, res) => {
  const userScript = req.body.script || "";
  const value = eval("(" + userScript + ")");
  res.json({ value });
});

app.get("/ops/lookup", (req, res) => {
  const host = req.query.host || "localhost";
  exec(`dig +short ${host}`, (err, stdout) => {
    if (err) return res.status(500).send(err.message);
    res.send(stdout);
  });
});

app.get("/ops/whois", (req, res) => {
  const domain = req.query.domain || "example.com";
  const output = execSync(`whois ${domain}`);
  res.send(output.toString());
});

app.listen(3000);
