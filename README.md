
```markdown
# Blockchain-Based SpotiPark App 🚗  
**Smart Parking using Blockchain Technology**  

SpotiPark est une application décentralisée (DApp) qui utilise la blockchain pour fournir un système de stationnement intelligent, sécurisé et transparent. Cette application permet aux utilisateurs de réserver des places de stationnement tout en garantissant la sécurité des transactions grâce à la technologie blockchain.

## Model Overview 🧠  
Le modèle mis en place pour SpotiPark repose sur la combinaison de technologies blockchain (Ethereum et Polygon/Matic) et une application mobile Flutter pour une expérience utilisateur fluide. L'objectif principal est de permettre un système de stationnement intelligent, sécurisé, transparent, et décentralisé. Voici un aperçu des fonctionnalités principales et du flux de travail :

### Smart Contract  
Le modèle sous-jacent utilise des **contrats intelligents** pour gérer les transactions de réservation de places de stationnement. Les utilisateurs peuvent réserver, libérer, et consulter la disponibilité des places via des appels à ces contrats. Les transactions sont enregistrées sur la blockchain, garantissant leur transparence et leur sécurité.

- **Contract Address** : Une fois que vous déployez le contrat via Truffle, le contrat intelligent obtient une adresse unique qui est ensuite utilisée par l'application mobile pour interagir avec le contrat déployé sur la blockchain.
- **Fonctionnalités du contrat intelligent** :  
  - Réservation de places de stationnement
  - Libération de places de stationnement
  - Vérification de la disponibilité des places
  - Historique des transactions pour assurer la transparence

### AI Integration for License Plate Recognition 🤖  
Une fonctionnalité avancée de l'application consiste à utiliser **l'intelligence artificielle (IA)** pour détecter les plaques d'immatriculation des véhicules. Cela permet aux utilisateurs de s'authentifier de manière sécurisée et de garantir que la place de stationnement est attribuée au bon véhicule. L'IA permet de vérifier les véhicules entrants et de leur attribuer des places de manière automatique.

- **Modèle de détection de plaques d'immatriculation** : Le modèle d'IA utilise des algorithmes de reconnaissance d'images pour détecter et extraire les plaques d'immatriculation des véhicules.
- **Fonctionnement** : Une fois qu'un utilisateur arrive à une place de stationnement, l'application utilise l'IA pour capturer une image de la plaque d'immatriculation et la vérifier avec les informations de réservation sur la blockchain.

### User Roles 🧑‍🤝‍🧑  
Le système prend en charge différents rôles pour les utilisateurs :  
1. **Client Utilisateur** :  
   - Réserver une place de stationnement  
   - Consulter la disponibilité des places  
   - Gérer ses réservations  
2. **Propriétaire de Place de Stationnement** :  
   - Gérer la disponibilité des places  
   - Vérifier les réservations

Les utilisateurs peuvent choisir leur rôle dans l'application mobile au démarrage, et les permissions et l'interface seront adaptées en conséquence.

### Blockchain Transactions and Security 🔐  
L'application utilise **Ethereum** et **Polygon/Matic** comme chaînes de blocs pour effectuer les transactions. Cela permet de garantir que les réservations sont sécurisées et que les informations sont enregistrées de manière immuable.

- **Ethereum pour la sécurité** : Toutes les transactions de réservation sont enregistrées sur Ethereum, offrant une sécurité robuste.
- **Polygon/Matic pour les frais réduits** : Polygon est utilisé pour réduire les frais de transaction tout en maintenant la sécurité de la blockchain Ethereum.

---

## Technology Stack 💻  
- **Ethereum Blockchain**  
- **Polygon/Matic**  
- **Web3Dart**  
- **Flutter**  
- **Metamask**  

---

## To Run Application Locally 🛠️  

### 1. Clone the Repository  
Clone the repository and navigate into the project folder:  
```bash
git clone <repository-url>
cd <repository-folder>
```  

### 2. Install Dependencies  
- **Flutter 3.0.2**  
  Install Flutter from [Flutter Installation Guide](https://docs.flutter.dev/get-started/install).  
- **Node.js**  
  Install Node.js from [Node.js official website](https://nodejs.org/).  

### 3. Install Ganache and Truffle  
Install Truffle globally using npm:  
```bash
npm install -g truffle
```  
Download and set up **Ganache** from [Truffle Suite](https://trufflesuite.com/ganache/). Keep Ganache running in the background.

### 4. Install Metamask  
- Install the [Metamask Chrome extension](https://metamask.io/).  
- Select the local network and import the accounts from Ganache into Metamask.  

### 5. Compile and Migrate Smart Contracts  
Run the following commands to compile and migrate the smart contracts:  
```bash
truffle compile
truffle migrate
```  

After the migration, copy the **contract address** shown in the output and paste it in the `contractAddress` variable located in `./lib/constant/constant.dart`.  

#### Example Migration Output:  
```plaintext
2_deploy_migration.js
=====================

Replacing 'SmartParking'
----------------
> transaction hash:    0x427b2b402f767ac6a90334ab3c687b086b274de747fe10d6e194743b15057d78
> Blocks: 0            Seconds: 0
> Contract address:    0xed690C24C60A48F8A9819c9A15AD75B70CFBEa5a
> Block number:        3
> Block timestamp:     1650602828
> Account:             0x33e94e4619f0AecDf81e9676Eb82c109FBa53356
> Gas used:            3996227
> Gas price:           20 gwei
> Value sent:          0 ETH
> Total cost:          0.07992454 ETH
```  

### 6. Update `constant.dart` Configuration  
Modify the following values in `constant.dart`:  
- **`contractAddress`**: Paste the contract address you obtained in the migration step.  
- **`chainId`**: Set it to `'1337'` (local network ID).  
- **`rpcUrl`**: Set it to `"http://127.0.0.1:7545"`.  

### 7. Configure Mapbox API Key  
Create a Mapbox API key from [Mapbox](https://www.mapbox.com/).  
Replace the `mapBoxApiKey` value in `constant.dart` with your generated API key.  

### 8. Run the Flutter Web App  
Install the necessary Flutter dependencies:  
```bash
flutter pub get
```  

Run the application in web mode:  
```bash
flutter run -d web-server --web-port 5555
```  

The app will be available at:  
[http://localhost:5555/](http://localhost:5555/)  

---

## Screenshots 📸  

- **Splash Screen**  
![Splash Screen](https://github.com/user-attachments/assets/3c289149-4cef-4405-9a6b-cf2cc01512a0)

- **Homepage**  
![Homepage](https://github.com/user-attachments/assets/536f4fc3-3dea-4805-92ae-56a3f0831b60)

- **Choosing Your Role**  
![Choosing Your Role](https://github.com/user-attachments/assets/799b2663-3148-4ea5-b604-dcedc7284266)

- **User Mobile App Screenshots**  
![User App 1](https://github.com/user-attachments/assets/d95ab422-be2b-4e65-9bf7-3d4bfda63d56)  
![User App 2](https://github.com/user-attachments/assets/019e350c-de40-487e-9c75-0a0e583893fe)  
![User App 3](https://github.com/user-attachments/assets/fb1d4887-d602-49b9-9180-712005a14784)  
![User App 4](https://github.com/user-attachments/assets/c400ac98-293f-463b-ba45-02ed9e3d159f)  
![User App 5](https://github.com/user-attachments/assets/f71ea755-0de7-4a7a-ac13-16e6671cb3ad)  
![User App 6](https://github.com/user-attachments/assets/31330cc7-404c-4ef3-9fb1-ba9215d41577)  
![User App 7](https://github.com/user-attachments/assets/db59e148-7e45-46d6-8490-660ce92be4c4)

- **AI Option to Detect the License Plate**  
![AI License Plate Detection](https://github.com/user-attachments/assets/e8032ddb-73eb-4b47-baca-9ee815aec50a)





## Author ✨  
Developed by **Charfi Safa**.  

---

## Additional Notes 📝  
Feel free to contribute to this project by submitting issues or creating pull requests!
```
