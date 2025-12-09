// Update this URL after running terraform apply
// Get the API Gateway URL from terraform outputs
const API_URL = "YOUR_API_GATEWAY_URL_HERE"; // Replace with actual API Gateway URL from terraform output

fetch(API_URL)
  .then(response => response.json())
  .then(data => {
    document.getElementById("visitor-count").innerText = data.visits;
  })
  .catch(err => {
    console.error("Error fetching visitor count:", err);
    document.getElementById("visitor-count").innerText = "Error loading count";
  });
