# Deployment Guide for Code Review Rules CAP App

This guide explains how to deploy the CAP application to a **new BTP account** and set up **machine-to-machine (M2M) access** for backend services.

---

## Deployment on a New BTP Account

Follow these steps to deploy the application from scratch:

1. **Replace `mta.yaml`**  
   Replace the content of the project root `mta.yaml` with `util/mta.yaml`.  
   > This version will create all required services from scratch rather than relying on existing instances.

2. **Install dependencies and create initial deploy**  
   ```bash
   npm install
   npm run go