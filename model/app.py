from flask import Flask, request, jsonify
from ultralytics import YOLO
import cv2 as cv
import numpy as np
import os

app = Flask(__name__)

# Base directory pointing to the `model` folder
base_dir = os.path.abspath(os.path.dirname(__file__))
print("Base directory:", base_dir)  # Debugging output

# Correct model file paths (updated to match your actual paths)
plate_model_path = os.path.join(base_dir, 'plate_model', 'best.pt')
character_model_path = os.path.join(base_dir, 'characters_model', 'best.pt')

# Debugging: Confirm resolved paths
print("Resolved Plate Model Path:", plate_model_path)
print("Resolved Character Model Path:", character_model_path)

# Load models with existence checks
try:
    if not os.path.exists(plate_model_path):
        raise FileNotFoundError(f"Plate model file does not exist at: {plate_model_path}")
    if not os.path.exists(character_model_path):
        raise FileNotFoundError(f"Character model file does not exist at: {character_model_path}")

    # Load the YOLO models
    plate_model = YOLO(plate_model_path)
    character_model = YOLO(character_model_path)
    print("YOLO models loaded successfully.")
except Exception as e:
    print("Error loading models:", e)

# Helper function to safely decode uploaded images
def read_image(file):
    try:
        file_content = file.read()
        if len(file_content) == 0:
            print("Error: Uploaded file is empty.")
            return None

        file_bytes = np.frombuffer(file_content, np.uint8)
        image = cv.imdecode(file_bytes, cv.IMREAD_COLOR)

        if image is None:
            print("Error decoding image.")
            return None

        return image
    except Exception as e:
        print("Error decoding image:", e)
        return None


# Route to handle the image for license plate detection
@app.route('/detect-plate', methods=['POST'])
def detect_plate():
    if 'image' not in request.files:
        return jsonify({"error": "No image file provided"}), 400

    file = request.files['image']
    if not file:
        return jsonify({"error": "Uploaded file is invalid"}), 400

    # Decode uploaded image
    image = read_image(file)

    if image is None:
        return jsonify({"error": "Could not decode image"}), 400

    try:
        # Run the detection model
        results = plate_model.predict(image)
        boxes = results[0].boxes.xyxy.cpu().numpy()

        if len(boxes) == 0:
            return jsonify({"error": "No license plate detected"}), 404

        # Process the first detected box
        x1, y1, x2, y2 = map(int, boxes[0])
        plate_image = image[y1:y2, x1:x2]

        # Simulated recognition (replace with actual character recognition logic)
        recognized_text = "DetectedText"

        return jsonify({"plate_number": recognized_text})

    except Exception as e:
        print("Error during detection pipeline:", e)
        return jsonify({"error": "Processing error"}), 500


if __name__ == '__main__':
    app.run(host='192.168.0.108', port=5000, debug=True)
