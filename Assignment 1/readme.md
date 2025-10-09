# 🐍 Jaclang Assignment: AI-Powered Applications

This repository contains the solution for a two-part Jaclang assignment focused on demonstrating **Scale-Agnostic Programming** (Cloud-Readiness) and **AI Integration** using the `byLLM` plugin.

The project is structured into two applications:
1.  **AI-Enhanced Guessing Game:** The completed tutorial example utilizing Jac's core features.
2.  **AI-Powered To-Do List:** A custom application that uses an LLM to automatically suggest task priorities.

---

## 🛠️ Setup and Installation

### Prerequisites

You must have Python installed and access to a terminal.

1.  **Install Jaclang and the AI Plugin:**
    ```bash
    pip install jac-lang jac-byllm
    ```

2.  **Get Your Gemini API Key:**
    * Obtain a key from the **Google AI Studio** (`https://aistudio.google.com/app/apikey`).

3.  **Set Environment Variable:**
    * The applications require your API key to be set as an environment variable to connect to the Gemini model.

    ```bash
    # For Linux/macOS
    export GEMINI_API_KEY="YOUR_GEMINI_API_KEY"

    # For Windows (Command Prompt)
    set GEMINI_API_KEY="YOUR_GEMINI_API_KEY"
    ```

---

## 📂 Project Structure

The repository contains four core files: