import os
import streamlit as st
from langchain.llms import OpenAI as LangchainOpenAI

# Configuration d'OpenAI avec votre clé d'API
os.environ['OPENAI_API_KEY'] = st.secrets["auth"]

# Configuration de la page
st.set_page_config(page_title='Générateur de Messages pour Avocats', page_icon="⚖️", layout="wide", initial_sidebar_state="expanded")


# Titre avec emoji
st.title('Générateur de Messages pour Avocats 📜')

# Paragraphe introductif
st.write("""
Ce générateur est conçu pour aider les avocats à rédiger des messages professionnels rapidement et efficacement. 
Que ce soit pour communiquer avec des clients, des collègues ou d'autres parties prenantes, cet outil offre une variété de modèles de messages adaptés à diverses situations juridiques. 
Il suffit de sélectionner la catégorie et le type de message, de fournir les détails nécessaires, et le générateur produira un message adapté à vos besoins. 
Gagnez du temps et assurez-vous que vos communications sont claires et professionnelles.
""")

# Note sur le caractère provisoire du projet
st.warning("""
⚠️ Ce projet est actuellement en phase bêta. Il est conçu pour démontrer les possibilités d'utilisation de l'automatisation dans le domaine juridique. 
Pour plus d'informations ou des demandes spécifiques, veuillez nous contacter via [leblanc-automatisation-ia.ch](https://leblanc-automatisation-ia.ch/).
""")

# Catégories et sous-catégories de messages
categories = {
    "Communication avec les clients": ["Mise à jour du dossier", "Demande de documents", "Rendez-vous", "Facturation", "Feedback"],
    "Relations avec les tribunaux": ["Demande d'audience", "Soumission de documents", "Demande de report", "Confirmation de présence", "Demande d'informations"],
    "Interactions avec les adversaires": ["Négociation", "Demande de documents", "Proposition de règlement", "Notification", "Demande de rendez-vous"],
    "Demandes à des experts": ["Demande d'expertise", "Rendez-vous", "Soumission de documents", "Feedback", "Facturation"],
    "Correspondance avec les témoins": ["Demande de témoignage", "Confirmation de présence", "Préparation", "Remerciements", "Feedback"],
    "Relations avec les médias": ["Communiqué de presse", "Interview", "Clarification", "Demande de correction", "Invitation à un événement"],
    "Gestion interne du cabinet": ["Mise à jour aux partenaires", "Demande de ressources", "Planification de réunions", "Feedback sur un cas", "Notifications générales"]
}

# Sélection de la catégorie et de la sous-catégorie
categorie = st.selectbox('Sélectionnez une catégorie:', list(categories.keys()))
sous_categorie = st.selectbox('Sélectionnez une sous-catégorie:', categories[categorie])

# Format de message
format_message = st.radio("Format du message:", ["Lettre", "E-mail"])

# Informations de base
st.header('Informations de Base ⚙️')
nom = st.text_input('Votre nom complet')
adresse = st.text_input('Votre adresse')
date = st.date_input('Date du message')
societe = st.text_input('Nom de la société ou de l entité concernée')
adresse_societe = st.text_input("Adresse de la société ou de l'entité concernée")
telephone = st.text_input("Votre numéro de téléphone")
email = st.text_input("Votre adresse e-mail")

# Informations sur le destinataire
st.header('Informations sur le Destinataire 📬')
nom_destinataire = st.text_input("Nom du destinataire")
adresse_destinataire = st.text_input("Adresse du destinataire")

# Détails supplémentaires
st.header('Détails Supplémentaires 🖊️')
details = st.text_area('Détails ou informations supplémentaires concernant votre demande')

# Générer le message
def generate_message(categorie, sous_categorie, format_message, nom, adresse, date, details, societe, adresse_societe, telephone, email, nom_destinataire, adresse_destinataire):
    llm = LangchainOpenAI(model_name='gpt-3.5-turbo-16k', temperature=0.2)
    prompt = f"Générer un message de type {sous_categorie} (format: {format_message}) pour {nom} résidant à {adresse} daté du {date}, concernant {societe} située à {adresse_societe}. Détails supplémentaires : {details}. Contact : {telephone}, {email}. Destinataire : {nom_destinataire}, {adresse_destinataire}"
    response = llm.predict(prompt)
    return response

if st.button('Générer le message 🚀'):
    message = generate_message(categorie, sous_categorie, format_message, nom, adresse, date, details, societe, adresse_societe, telephone, email, nom_destinataire, adresse_destinataire)
    st.subheader('Message Généré 📄')
    st.text_area("", message, height=300)

# Section d'aide et de support
st.sidebar.header('Aide & Support 🆘')
st.sidebar.text("Besoin d'aide ?")
st.sidebar.text("Consultez notre FAQ ou contactez-nous directement.")
