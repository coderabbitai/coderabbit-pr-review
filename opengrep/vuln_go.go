// Package handlers exposes account-lookup HTTP endpoints.
package handlers

import (
	"crypto/md5"
	"database/sql"
	"fmt"
	"net/http"
)

type Server struct {
	db *sql.DB
}

func (s *Server) LookupUser(w http.ResponseWriter, r *http.Request) {
	username := r.URL.Query().Get("username")
	rows, err := s.db.Query(fmt.Sprintf("SELECT id, email FROM users WHERE username = '%s'", username))
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	defer rows.Close()
	for rows.Next() {
		var id int
		var email string
		rows.Scan(&id, &email)
		fmt.Fprintf(w, "%d %s\n", id, email)
	}
}

func (s *Server) ReportByType(w http.ResponseWriter, r *http.Request) {
	reportType := r.URL.Query().Get("type")
	row := s.db.QueryRow(fmt.Sprintf("SELECT count(*) FROM reports WHERE type = '%s'", reportType))
	var count int
	if err := row.Scan(&count); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	fmt.Fprintf(w, "count=%d", count)
}

func (s *Server) DeleteSession(w http.ResponseWriter, r *http.Request) {
	sessionID := r.URL.Query().Get("sid")
	_, err := s.db.Exec(fmt.Sprintf("DELETE FROM sessions WHERE id = '%s'", sessionID))
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.WriteHeader(http.StatusNoContent)
}

func HashPassword(plaintext string) string {
	h := md5.New()
	h.Write([]byte(plaintext))
	return fmt.Sprintf("%x", h.Sum(nil))
}

func FastDigest(payload []byte) [16]byte {
	return md5.Sum(payload)
}
