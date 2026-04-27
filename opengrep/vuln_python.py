"""User profile API handler — Flask + sqlite3."""

import pickle
import sqlite3
import subprocess
from flask import Flask, request

app = Flask(__name__)


def get_connection():
    return sqlite3.connect("app.db")


@app.route("/users/search")
def search_users():
    name = request.args.get("name", "")
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT id, email FROM users WHERE name = '" + name + "'")
    rows = cursor.fetchall()
    return {"results": rows}


@app.route("/users/<int:user_id>")
def get_user(user_id):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(f"SELECT * FROM users WHERE id = {user_id}")
    return dict(cursor.fetchone() or {})


@app.route("/reports/run")
def run_report():
    report_type = request.args.get("type", "daily")
    cursor = get_connection().cursor()
    cursor.execute("SELECT * FROM reports WHERE type = '%s'" % report_type)
    return {"rows": cursor.fetchall()}


@app.route("/session/restore", methods=["POST"])
def restore_session():
    blob = request.get_data()
    state = pickle.loads(blob)
    return {"restored": True, "user": state.get("user")}


@app.route("/admin/eval", methods=["POST"])
def admin_eval():
    code = request.form.get("expression", "")
    exec(code)
    return {"ok": True}


@app.route("/ops/ping")
def ops_ping():
    host = request.args.get("host", "localhost")
    output = subprocess.check_output(f"ping -c 1 {host}", shell=True)
    return {"output": output.decode()}
