
# Blockchain-Based SpotiPark App 🚗  
**Smart Parking using Blockchain Technology**  

SpotiPark est une application décentralisée (DApp) qui utilise la blockchain pour offrir un système de stationnement intelligent, sécurisé et transparent. Cette application permet aux utilisateurs de réserver des places de stationnement tout en garantissant la sécurité des transactions grâce à la technologie blockchain.

## Table of Contents
1. [Part 1: Blockchain-Based DApp](#part-1-blockchain-based-dapp)
   - [Overview](#overview)
   - [Smart Contracts](#smart-contracts)
   - [Ethereum and Polygon](#ethereum-and-polygon)
   - [User Roles](#user-roles)
   - [Blockchain Transactions and Security](#blockchain-transactions-and-security)
2. [Part 2: AI Integration for License Plate Recognition](#part-2-ai-integration-for-license-plate-recognition)
   - [AI Model Overview](#ai-model-overview)
   - [Technologies Used](#technologies-used)
   - [Model Workflow](#model-workflow)
3. [Getting Started](#getting-started)
   - [Clone the Repository](#clone-the-repository)
   - [Install Dependencies](#install-dependencies)
   - [Configure and Run](#configure-and-run)
4. [Screenshots](#screenshots)
5. [License](#license)
6. [Author](#author)

---

## Part 1: Blockchain-Based DApp 💻

### Overview  
Le modèle de SpotiPark repose sur une architecture **Blockchain** décentralisée. L'application permet aux utilisateurs de réserver et libérer des places de stationnement en toute transparence, tout en garantissant la sécurité et l'immuabilité des transactions via la technologie Blockchain. Le cœur de l'application repose sur un **smart contract** déployé sur le réseau Ethereum et étendu avec **Polygon (Matic)** pour la gestion des frais de transaction.

### Smart Contracts 📝  
Les **smart contracts** sont au cœur de l'application SpotiPark. Ils définissent les règles du système de réservation de stationnement. Le contrat intelligent gère les réservations, la vérification des places disponibles, et l'enregistrement des transactions sur la blockchain. 

- **Fonctions du Smart Contract** :  
  - **Réservation d'une place** : Permet à l'utilisateur de réserver une place en fonction de l'heure et de la date.  
  - **Libération de la place** : L'utilisateur libère la place une fois qu'il a terminé.  
  - **Vérification de la disponibilité** : Le contrat vérifie si une place est disponible avant qu'un utilisateur ne réserve.  
  - **Historique des transactions** : Toutes les actions de réservation sont enregistrées sur la blockchain pour assurer la transparence.

  Les contrats sont déployés à l'aide de **Truffle** et testés localement via **Ganache** avant d'être mis en production sur Ethereum.

### Ethereum and Polygon 🌐  
Le réseau **Ethereum** est utilisé pour la sécurité et la transparence des transactions. Polygon (anciennement Matic) est intégré pour réduire les frais de transaction tout en maintenant la sécurité d'Ethereum. Polygon permet des transactions plus rapides et moins coûteuses.

- **Ethereum** :  
  Ethereum est une plateforme de blockchain décentralisée qui permet d'exécuter des contrats intelligents. Les utilisateurs interagissent avec l'application via **Metamask** pour autoriser les transactions.

- **Polygon (Matic)** :  
  Polygon améliore la scalabilité de la blockchain Ethereum en permettant des transactions rapides et bon marché. Cela permet aux utilisateurs de profiter d'un réseau Ethereum sécurisé tout en réduisant les coûts liés aux interactions avec la blockchain.

### User Roles 🧑‍🤝‍🧑  
L'application SpotiPark gère différents rôles pour les utilisateurs. Voici les deux rôles principaux :

1. **Utilisateur final** :  
   - Réserver une place de stationnement.
   - Libérer une place de stationnement.
   - Consulter la disponibilité des places.
   - Visualiser l'historique des réservations.

2. **Propriétaire de place de stationnement** :  
   - Gérer la disponibilité des places (activer ou désactiver une place).
   - Vérifier les réservations et voir l'historique.

### Blockchain Transactions and Security 🔐  
La sécurité des transactions est assurée par le réseau Ethereum, qui utilise la **cryptographie** pour valider et sécuriser les transactions. Les utilisateurs doivent signer leurs transactions via **Metamask**, une extension de navigateur, ce qui garantit l'authenticité de chaque réservation ou modification de statut.

- **Ethereum pour la sécurité** : Toutes les transactions sont enregistrées sur Ethereum, offrant une sécurité robuste.
- **Polygon pour la réduction des coûts** : Les transactions sur Polygon sont plus rapides et moins coûteuses, ce qui rend le processus plus fluide pour les utilisateurs.

---

## Part 2: AI Integration for License Plate Recognition 🤖

### AI Model Overview  
SpotiPark intègre un modèle d'intelligence artificielle (IA) pour la reconnaissance des plaques d'immatriculation. Cette fonctionnalité permet de sécuriser l'accès au parking et de vérifier que la place réservée est attribuée au bon véhicule.

- **Objectif** : Lorsqu'un utilisateur arrive sur le parking, l'application utilise un modèle de détection d'image pour capturer la plaque d'immatriculation du véhicule et la comparer avec les réservations existantes sur la blockchain. Cela permet de s'assurer que la place réservée est utilisée par le bon véhicule.

### Technologies Used 🧰  
- **TensorFlow** : Utilisé pour le développement du modèle de reconnaissance d'images. TensorFlow est une bibliothèque de machine learning open-source qui permet d'entraîner et de déployer des modèles d'IA.
- **OpenCV** : Bibliothèque open-source pour la manipulation d'images. OpenCV est utilisé pour le traitement des images des plaques d'immatriculation capturées par la caméra.
- **Keras** : API haut niveau pour TensorFlow, utilisée pour créer, entraîner et tester des modèles d'apprentissage profond pour la reconnaissance des plaques.
- **YOLO (You Only Look Once)** : Modèle de détection d'objets utilisé pour détecter et localiser la plaque d'immatriculation dans les images en temps réel. YOLO est utilisé pour sa rapidité et son efficacité dans la détection d'objets.
- **Tesseract OCR** : Outil de reconnaissance optique de caractères utilisé pour extraire les numéros de la plaque d'immatriculation à partir de l'image.

### Model Workflow 🧑‍💻

1. **Capture d'image** : Lorsqu'un véhicule arrive, l'application utilise la caméra pour capturer l'image de la plaque d'immatriculation.
2. **Prétraitement de l'image** : L'image est ensuite traitée avec **OpenCV** pour améliorer sa qualité et faciliter la détection de la plaque.
3. **Détection de la plaque** : Le modèle YOLO détecte et localise la plaque d'immatriculation dans l'image capturée.
4. **Reconnaissance du texte** : Le texte sur la plaque d'immatriculation est extrait à l'aide de **Tesseract OCR**.
5. **Vérification de la réservation** : L'application vérifie si le numéro de plaque détecté correspond à une réservation existante dans la base de données blockchain. Si une correspondance est trouvée, l'accès au parking est accordé.

### AI Model Deployment 🌍  
Le modèle IA est intégré directement dans l'application mobile, fonctionnant en temps réel pour détecter les plaques d'immatriculation et effectuer des vérifications instantanées. Il est hébergé sur un serveur central qui communique avec l'application via une API pour garantir la précision et la rapidité du processus.

---

## Getting Started 🛠️

### Clone the Repository  
Clone the repository and navigate into the project folder:  
```bash
git clone <repository-url>
cd <repository-folder>
```  

### Install Dependencies  
- **Flutter** : Install Flutter from [Flutter Installation Guide](https://docs.flutter.dev/get-started/install).  
- **Node.js** : Install Node.js from [Node.js official website](https://nodejs.org/).  

### Configure and Run  
Follow the steps to set up **Truffle**, **Ganache**, **Metamask**, and configure the **Mapbox API** key. Then, run the following commands to deploy the smart contract and start the mobile app.

---

## Screenshots 📸  

- **Splash Screen**  
![Splash Screen](https://github.com/user-attachments/assets/3c289149-4cef-4405-9a6b-cf2cc01512a0)

- **Homepage**  
![Homepage](https://github.com/user-attachments/assets/536f4fc3-3dea-4805-92ae-56a3f0831b60)

- **Choosing Your Role**  
![Choosing Your Role](https://github.com/user-attachments/assets/799b2663-3148-4ea5-b604-dcedc7284266)





## Author ✨  
Developed by **Charfi Safa**.  

---

## Additional Notes 📝  
Feel free to contribute to this project by submitting issues or creating pull requests!

