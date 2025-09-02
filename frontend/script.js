fetch("https://<API-GATEWAY-ID>.execute-api.<AWS-REGION>.amazonaws.com/prod/")
  .then(response => response.json())
  .then(data => {
    document.getElementById("visitor-count").innerText = data.visits;
  })
  .catch(err => console.error(err));
