// Particle41 DevOps Team Challenge

package main

import (
	"encoding/json"
	"log"
	"net"
	"net/http"
	"time"
)

// Response structure
type Response struct {
	Timestamp string `json:"timestamp"`
	IP        string `json:"ip"`
}

// Function to get the client's IP address
func getClientIP(r *http.Request) string {
	// Get the IP address from the request headers
	ip := r.Header.Get("X-Forwarded-For")
	if ip == "" {
		ip = r.Header.Get("X-Real-IP")
	}
	if ip == "" {
		ip, _, _ = net.SplitHostPort(r.RemoteAddr)
	}
	return ip
}

// Function to generate response data
func generateResponse(r *http.Request) Response {

	timestamp := time.Now().Format(time.RFC3339) // Get the current timestamp
	clientIP := getClientIP(r)                   // Get the IP address of the visitor

	return Response{
		Timestamp: timestamp,
		IP:        clientIP,
	}
}

// API handler
func apiHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	response := generateResponse(r)
	json.NewEncoder(w).Encode(response)
}

// Setup Routes
func setupRoutes() {
	http.HandleFunc("/", apiHandler)
}

// Main function
func main() {
	setupRoutes()
	log.Println("App started on port 8080")
	log.Fatal(http.ListenAndServe("0.0.0.0:8080", nil))
}
