import express from "express";
const app = express();
const PORT = 3000
const url = "http://localhost:8000"


// Route to render HTML content
app.get('/health/api', (req, res) => {
    return res.send('<strong>hello healthy api </strong>')
})

app.get('/', (req, res) => {
    let html = `<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>To-Do list</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }
        #itemForm {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }
        div {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }
        input, textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }
        input:focus, textarea:focus {
            outline: none;
            border-color: #4CAF50;
            box-shadow: 0 0 5px rgba(76, 175, 80, 0.3);
        }
        button {
            width: 100%;
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>

<body>
    <h1> This is TuteDude CI/CD practice project </h1>
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
