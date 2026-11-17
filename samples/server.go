package main

import (
	"encoding/json"
	"log"
	"net/http"
	"time"
)

const defaultTimeout = 5 * time.Second

// Palette maps a role to a hex color.
type Palette map[string]string

type Server struct {
	themes map[string]Palette
	logger *log.Logger
}

func (s *Server) handleTheme(w http.ResponseWriter, r *http.Request) {
	name := r.URL.Query().Get("name")
	palette, ok := s.themes[name]
	if !ok {
		http.Error(w, "unknown theme: "+name, http.StatusNotFound)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	if err := json.NewEncoder(w).Encode(palette); err != nil {
		s.logger.Printf("encode %q: %v", name, err)
	}
}

func main() {
	srv := &Server{themes: map[string]Palette{}, logger: log.Default()}
	http.HandleFunc("/theme", srv.handleTheme)
	log.Fatal(http.ListenAndServe(":8080", nil))
}
