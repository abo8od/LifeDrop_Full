# Donor App (Flutter) - Product Requirements

## Overview
The Donor App is a mobile application built with Flutter that allows users to receive and respond to blood donation requests in real time. It focuses on simplicity, speed, and reliability during emergencies.

---

## Core Features

### 1. Authentication & Profile
- User registration & login
- Store:
  - Name
  - Blood type
  - Phone number
- Account status:
  - Verified / Unverified
- Profile management

---

### 2. Receive Blood Requests
- Push notifications for new requests
- Request includes:
  - Blood type
  - Hospital name
  - Location
  - Priority level (Critical / Urgent / Normal)

---

### 3. Accept / Cancel Request
- Accept request button
- Cancel option (only before arrival)
- Show request status:
  - Pending
  - Accepted
  - Completed

---

### 4. Smart Notification Behavior
- Critical:
  - High priority (override silent mode)
- Urgent:
  - Normal notification
- Normal:
  - Silent (inside app feed)

---

### 5. Real-Time Updates
- Use WebSockets
- Features:
  - Remove request when quota is full
  - Update request status instantly

---

### 6. Navigation to Hospital
- "Start Navigation" button
- Open map (Google Maps API)
- Show fastest route

---

### 7. Availability & Cooldown
- After donation:
  - User becomes unavailable
- Show:
  - Countdown timer (e.g., 56 days)

---

### 8. Cancellation Handling
- If user cancels:
  - Request slot is freed
- Track user behavior:
  - Frequent cancellations reduce reliability score

---

### 9. Gamification
- Points for each donation
- Badges system:
  - Example: "Silver Savior"
- Leaderboard (optional)

---

### 10. Location Handling
- Use hybrid approach:
  - Static locations (home, university)
  - Update live location only when app is open

---

## Screens (UI)

### 1. Splash Screen
- Logo + loading indicator

### 2. Login / Register
- Phone or email input
- OTP verification

### 3. Home Screen
- List of active requests
- Priority indicators

### 4. Request Details Screen
- Full request info
- Accept button

### 5. Active Request Screen
- Status
- Cancel button
- Navigation button

### 6. Profile Screen
- User info
- Points & badges
- Availability status

---

## Technical Requirements

### State Management
- Bloc / Riverpod (recommended)

### Networking
- REST API + WebSockets

### Notifications
- Firebase Cloud Messaging (FCM)

### Maps
- Google Maps Flutter SDK

---

## Non-Functional Requirements

### Performance
- Fast response for notifications
- Smooth UI

### Reliability
- Handle offline cases
- Retry failed requests

### Security
- Secure API calls
- Protect user data

---

## Out of Scope
- Payments
- Chat between users
- Medical advice
