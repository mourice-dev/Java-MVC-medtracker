<!-- @format -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Medtracker - Find Medicine Easily in Kigali</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Lucide Icons -->
    <script src="https://unpkg.com/lucide@latest"></script>
    <!-- Leaflet CSS -->
    <link
      rel="stylesheet"
      href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"
      integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY="
      crossorigin="" />
    <style>
      .leaflet-pane {
        z-index: 10;
      }

      /* Fix for Tailwind z-index conflict if any */
    </style>
  </head>

  <body
    class="bg-slate-50 font-sans text-slate-800 selection:bg-teal-100 flex flex-col min-h-screen">
    <!-- Navigation -->
    <nav
      class="sticky top-0 z-50 bg-white/80 backdrop-blur-md border-b border-slate-100 transition-all duration-300">
      <div
        class="max-w-7xl mx-auto px-6 py-4 w-full flex justify-between items-center">
        <div
          class="flex items-center text-teal-600 group cursor-pointer"
          onclick="window.scrollTo(0, 0)">
          <div
            class="bg-teal-600 text-white p-2 rounded-lg mr-3 shadow-md group-hover:shadow-teal-500/50 transition-all duration-300">
            <i data-lucide="activity" width="24"></i>
          </div>
          <span class="text-2xl font-bold tracking-tight text-slate-800"
            >Med<span class="text-teal-600">tracker</span></span
          >
        </div>
        <div
          class="hidden md:flex space-x-8 text-sm font-semibold text-slate-600">
          <a href="#about" class="hover:text-teal-600 transition">About Us</a>
          <a href="#map" class="hover:text-teal-600 transition"
            >Find Medicine</a
          >
          <a href="#features" class="hover:text-teal-600 transition"
            >Features</a
          >
        </div>
        <div class="flex items-center space-x-4">
          <!-- Log In link removed for unrestricted access -->
          <a
            href="register.jsp"
            class="bg-slate-900 text-white px-5 py-2.5 rounded-xl text-sm font-bold hover:bg-slate-800 transition shadow-lg hover:shadow-xl transform hover:-translate-y-0.5">
            Sign Up
          </a>
        </div>
      </div>
    </nav>

    <!-- Hero Section -->
    <section class="relative pt-20 pb-32 overflow-hidden">
      <div class="max-w-7xl mx-auto px-6 relative z-10">
        <div class="grid lg:grid-cols-2 gap-16 items-center">
          <div class="space-y-8 animate-fade-in-up">
            <div
              class="inline-flex items-center space-x-2 bg-teal-50 text-teal-700 px-4 py-2 rounded-full text-sm font-bold border border-teal-100">
              <span class="relative flex h-2 w-2">
                <span
                  class="animate-ping absolute inline-flex h-full w-full rounded-full bg-teal-400 opacity-75"></span>
                <span
                  class="relative inline-flex rounded-full h-2 w-2 bg-teal-500"></span>
              </span>
              <span>Serving Kigali & Beyond</span>
            </div>
            <h1
              class="text-5xl md:text-7xl font-extrabold tracking-tight text-slate-900 leading-[1.1]">
              Find your medicine <br />
              <span
                class="text-transparent bg-clip-text bg-gradient-to-r from-teal-600 to-emerald-600"
                >in Kigali.</span
              >
            </h1>
            <p class="text-lg text-slate-500 max-w-lg leading-relaxed">
              Medtracker bridges the gap between patients and pharmacies across
              Kigali. Locate essential medicines in real-time, check stock at
              nearby pharmacies, and get the care you need without delay.
            </p>
            <div class="flex flex-col sm:flex-row gap-4 pt-4">
              <a
                href="#map"
                class="px-8 py-4 bg-teal-600 text-white rounded-xl font-bold text-lg hover:bg-teal-700 transition shadow-lg shadow-teal-600/30 flex items-center justify-center group">
                Locate Medicine
                <i
                  data-lucide="map-pin"
                  class="ml-2 group-hover:animate-bounce"
                  width="20"></i>
              </a>
              <a
                href="#about"
                class="px-8 py-4 bg-white border-2 border-slate-200 text-slate-700 rounded-xl font-bold text-lg hover:border-teal-200 hover:bg-teal-50 transition flex items-center justify-center">
                Learn More
              </a>
            </div>
          </div>

          <!-- Hero Visual -->
          <div class="relative hidden lg:block">
            <div
              class="absolute -inset-4 bg-gradient-to-r from-teal-500 to-emerald-500 rounded-full opacity-20 blur-3xl animate-pulse"></div>
            <img
              src="https://images.unsplash.com/photo-1576091160550-217358c7e618?auto=format&fit=crop&q=80&w=800"
              alt="Pharmacy Map Interaction"
              class="relative rounded-2xl shadow-2xl border-4 border-white rotate-2 hover:rotate-0 transition duration-700 object-cover h-[500px] w-full" />
            <!-- Floating Card -->
            <div
              class="absolute -bottom-10 -left-10 bg-white p-6 rounded-2xl shadow-xl border border-slate-100 animate-bounce duration-[3000ms]">
              <div class="flex items-center space-x-4">
                <div class="bg-green-100 p-3 rounded-full text-green-600">
                  <i data-lucide="check" width="24"></i>
                </div>
                <div>
                  <p class="text-sm text-slate-500 font-medium">
                    Verified Location
                  </p>
                  <p class="text-lg font-bold text-slate-800">
                    Nyarugenge District
                  </p>
                  <p class="text-xs text-teal-600">Open 24/7</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- About Us Section -->
    <section id="about" class="py-24 bg-white">
      <div class="max-w-7xl mx-auto px-6">
        <div class="text-center max-w-3xl mx-auto mb-16">
          <h2 class="text-3xl md:text-4xl font-bold text-slate-900 mb-4">
            About Medtracker
          </h2>
          <div class="h-1 w-20 bg-teal-500 mx-auto rounded-full mb-6"></div>
          <p class="text-slate-500 text-lg leading-relaxed">
            We are dedicated to improving healthcare access in
            <span class="text-teal-600 font-semibold"
              >Kigali and throughout Rwanda.</span
            >
            Our platform connects local pharmacies with patients, providing
            real-time inventory visibility to save time and lives.
          </p>
        </div>

        <div class="grid md:grid-cols-3 gap-8">
          <div
            class="bg-slate-50 p-8 rounded-2xl border border-slate-100 hover:shadow-lg transition duration-300">
            <div
              class="bg-blue-100 w-12 h-12 rounded-xl flex items-center justify-center text-blue-600 mb-6">
              <i data-lucide="users" width="24"></i>
            </div>
            <h3 class="text-xl font-bold text-slate-900 mb-3">
              Community First
            </h3>
            <p class="text-slate-500">
              Built for the Rwandan community. We empower local pharmacies and
              help patients navigate their healthcare needs.
            </p>
          </div>
          <div
            class="bg-slate-50 p-8 rounded-2xl border border-slate-100 hover:shadow-lg transition duration-300">
            <div
              class="bg-teal-100 w-12 h-12 rounded-xl flex items-center justify-center text-teal-600 mb-6">
              <i data-lucide="zap" width="24"></i>
            </div>
            <h3 class="text-xl font-bold text-slate-900 mb-3">
              Fast & Reliable
            </h3>
            <p class="text-slate-500">
              Real-time data updates ensure you never waste a trip. Know what's
              in stock before you leave your home.
            </p>
          </div>
          <div
            class="bg-slate-50 p-8 rounded-2xl border border-slate-100 hover:shadow-lg transition duration-300">
            <div
              class="bg-purple-100 w-12 h-12 rounded-xl flex items-center justify-center text-purple-600 mb-6">
              <i data-lucide="shield-check" width="24"></i>
            </div>
            <h3 class="text-xl font-bold text-slate-900 mb-3">
              Trusted Sources
            </h3>
            <p class="text-slate-500">
              We verify all listed pharmacies to ensure you receive safe and
              authentic medications every time.
            </p>
          </div>
        </div>
      </div>
    </section>

    <!-- Map Section -->
    <section id="map" class="py-24 bg-slate-50 relative">
      <div class="max-w-7xl mx-auto px-6">
        <div class="flex flex-col md:flex-row justify-between items-end mb-12">
          <div>
            <span
              class="text-teal-600 font-bold tracking-wider uppercase text-sm"
              >Kigali Live Map</span
            >
            <h2 class="text-3xl md:text-4xl font-bold text-slate-900 mt-2">
              Find Nearby Pharmacies
            </h2>
            <p class="text-slate-500 mt-4 max-w-lg">
              Browse our interactive map of Kigali to see pharmacies near you.
              Click on markers to view available medicines and contact details.
            </p>
          </div>
          <div class="mt-6 md:mt-0">
            <button
              onclick="getUserLocation()"
              class="bg-white text-teal-600 border border-teal-200 px-6 py-3 rounded-xl font-bold hover:bg-teal-50 transition flex items-center shadow-sm">
              <i data-lucide="crosshair" class="mr-2" width="20"></i> Use My
              Location
            </button>
          </div>
        </div>

        <!-- Map Container -->
        <div class="bg-white p-2 rounded-3xl shadow-xl border border-slate-200">
          <div
            id="pharmacy-map"
            class="h-[500px] w-full rounded-2xl z-10"></div>
        </div>
      </div>
    </section>

    <!-- Footer -->
    <footer class="bg-slate-900 text-slate-300 py-12">
      <div class="max-w-7xl mx-auto px-6 grid md:grid-cols-4 gap-8">
        <div class="col-span-1 md:col-span-2">
          <div class="flex items-center text-white mb-4">
            <i data-lucide="activity" class="mr-2" width="24"></i>
            <span class="text-xl font-bold">Medtracker</span>
          </div>
          <p class="text-gray-400 max-w-xs">
            Helping you find the right care at the right time. Serving Kigali,
            Rwanda.
          </p>
        </div>
        <div>
          <h4 class="text-white font-bold mb-4">Platform</h4>
          <ul class="space-y-2 text-sm">
            <li>
              <a href="#" class="hover:text-teal-400 transition"
                >Search Medicine</a
              >
            </li>
            <li>
              <a href="#" class="hover:text-teal-400 transition">Map View</a>
            </li>
            <!-- Pharmacy Login link removed for unrestricted access -->
          </ul>
        </div>
        <div>
          <h4 class="text-white font-bold mb-4">Contact</h4>
          <ul class="space-y-2 text-sm">
            <li>
              <a href="#" class="hover:text-teal-400 transition"
                >support@medtracker.rw</a
              >
            </li>
            <li>
              <a href="#" class="hover:text-teal-400 transition"
                >+250 788 123 456</a
              >
            </li>
          </ul>
        </div>
      </div>
      <div
        class="max-w-7xl mx-auto px-6 mt-12 pt-8 border-t border-slate-800 text-center text-sm text-slate-500">
        &copy; 2026 Medtracker Rwanda. All rights reserved.
      </div>
    </footer>

    <!-- Scripts -->
    <!-- Leaflet JS -->
    <script
      src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"
      integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo="
      crossorigin=""></script>

    <script>
      // Initialize Icons
      lucide.createIcons();

      // Initialize Map
      document.addEventListener("DOMContentLoaded", function () {
        // Center on Kigali, Rwanda
        const kigaliLat = -1.9441;
        const kigaliLng = 30.0619;
        const map = L.map("pharmacy-map").setView([kigaliLat, kigaliLng], 13); // Zoom level 13 is good for city view

        L.tileLayer(
          "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}",
          {
            attribution:
              "Tiles &copy; Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community",
            maxZoom: 19,
          },
        ).addTo(map);

        // Dummy Data for Pharmacies in Kigali
        const pharmacies = [
          {
            name: "Kigali City Market Pharmacy",
            lat: -1.9439,
            lng: 30.0594,
            stock: "High",
          },
          {
            name: "Remera Corner Pharmacy",
            lat: -1.9585,
            lng: 30.1114,
            stock: "Medium",
          },
          {
            name: "Nyamirambo Green Cross",
            lat: -1.9804,
            lng: 30.0538,
            stock: "High",
          },
          { name: "Kicukiro Center Meds", lat: -2.0, lng: 30.1, stock: "Low" },
          {
            name: "Gisozi Life Pharmacy",
            lat: -1.93,
            lng: 30.05,
            stock: "High",
          },
        ];

        // Custom Icon
        const pharmIcon = L.icon({
          iconUrl: "https://cdn-icons-png.flaticon.com/512/1685/1685230.png", // Generic pill icon or marker
          iconSize: [32, 32],
          iconAnchor: [16, 32],
          popupAnchor: [0, -32],
        });

        // Add markers
        pharmacies.forEach((p) => {
          L.marker([p.lat, p.lng])
            .addTo(map)
            .bindPopup(
              `<b>${p.name}</b><br>Stock Level: <span class="text-teal-600 font-bold">${p.stock}</span>`,
            );
        });

        // Expose function to finding user location
        window.getUserLocation = function () {
          if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(
              (position) => {
                const { latitude, longitude } = position.coords;
                map.flyTo([latitude, longitude], 14);

                L.marker([latitude, longitude])
                  .addTo(map)
                  .bindPopup("You are here")
                  .openPopup();
              },
              () => {
                alert("Unable to retrieve your location.");
              },
            );
          } else {
            alert("Geolocation is not supported by your browser.");
          }
        };
      });
    </script>
  </body>
</html>
