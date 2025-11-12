import express from "express";
const app = express();
const PORT = 3000
const url = "http://localhost:8000"

 
// Route to render HTML content
app.get('/health/api', (req, res) =>{
  return res.send('<strong>hello healthy api </strong>')
})

app.get('/', (req, res) => {
  let html = `<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>To-Do list</title>
</head>

<body>
    <form id="itemForm">
        <div>
            <label for="itemName">Item Name:</label>
            <input type="text" id="itemName" name="itemName" required>
        </div>
        <div>
            <label for="itemDescription">Item Description:</label>
            <textarea id="itemDescription" name="itemDescription" required></textarea>
        </div>
        <button type="submit">Submit</button>
    </form>

    <script>
        document.getElementById('itemForm').addEventListener('submit', function (e) {
            e.preventDefault();

            const itemName = document.getElementById('itemName').value;
            const itemDescription = document.getElementById('itemDescription').value;

            fetch("${url}/api/todo", {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    itemName: itemName,
                    itemDescription: itemDescription
                })
            })
                .then(response => response.json())
                .then(data => alert('Success'))
                .catch(error => {console.log(error);alert('Error')});
        });
    </script>
</body>

</html>`;
  res.send(html);
});

// Start the server
app.listen(PORT, () => {
  console.log(`✅ Server running at http://localhost:${PORT}`);
});
