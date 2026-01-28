<!-- @format -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Find Medicine - MedicTrack</title>
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
    <!-- Leaflet JS -->
    <script
      src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"
      integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo="
      crossorigin=""></script>

    <style>
      #map {
        height: calc(100vh - 80px);
        width: 100%;
        z-index: 0;
      }
      .sidebar {
        z-index: 1000;
      }
    </style>
  </head>
  <body
    class="bg-slate-50 font-sans text-slate-800 overflow-hidden flex flex-col h-screen">
    <!-- Navigation -->
    <nav class="bg-white border-b border-slate-200 h-20 shadow-sm z-50">
      <div
        class="max-w-7xl mx-auto px-6 h-full flex justify-between items-center">
        <div
          class="flex items-center text-teal-600 cursor-pointer"
          onclick="window.location.href = 'index.jsp'">
          <div class="bg-teal-600 text-white p-1.5 rounded-lg mr-2 shadow-sm">
            <i data-lucide="activity" width="24" height="24"></i>
          </div>
          <span class="text-2xl font-bold tracking-tight text-slate-800"
            >Medic<span class="text-teal-600">Track</span></span
          >
        </div>

        <div class="flex-1 max-w-xl mx-8 hidden md:block group relative">
          <div class="relative">
            <i
              data-lucide="search"
              class="absolute left-3 top-3 text-slate-400"
              width="20"></i>
            <input
              type="text"
              id="medicine-search"
              placeholder="Search for medicine (e.g., Amoxicillin, Panadol)..."
              class="w-full bg-slate-100 border-none rounded-xl py-3 pl-10 pr-4 text-slate-800 focus:ring-2 focus:ring-teal-500 focus:bg-white transition shadow-sm font-medium" />
          </div>
        </div>

        <div class="flex items-center space-x-4">
          <a
            class="font-bold text-slate-600 hover:text-teal-600 hidden sm:block"
            >Log In</a
          >
          <a
            class="bg-slate-900 text-white px-5 py-2.5 rounded-xl text-sm font-bold hover:bg-slate-800 transition shadow-lg hover:shadow-xl"
            >For Clinics</a
          >
        </div>
      </div>
    </nav>

    <div class="flex flex-1 relative overflow-hidden">
      <!-- Sidebar List (Desktop) -->
      <div
        class="w-96 bg-white border-r border-slate-200 flex flex-col shadow-xl z-10 absolute md:relative h-full transform -translate-x-full md:translate-x-0 transition-transform duration-300"
        id="sidebar">
        <div class="p-6 border-b border-slate-100 bg-slate-50">
          <div class="flex justify-between items-center mb-2">
            <h2 class="text-lg font-bold text-slate-800">Nearby Pharmacies</h2>
            <span
              class="text-xs font-semibold bg-teal-100 text-teal-700 px-2 py-1 rounded-full"
              >Kigali, RW</span
            >
          </div>
          <p class="text-sm text-slate-500">
            Showing pharmacies with confirmed stock levels.
          </p>
        </div>
        <div class="overflow-y-auto flex-1 p-4 space-y-4" id="pharmacy-list">
          <!-- Pharmacy items will be injected here via JS -->
        </div>
      </div>

      <!-- Toggle Sidebar Button (Mobile) -->
      <button
        id="toggle-sidebar"
        class="md:hidden absolute top-4 left-4 z-20 bg-white p-3 rounded-xl shadow-lg border border-slate-200 text-slate-600">
        <i data-lucide="menu" width="24"></i>
      </button>

      <!-- Map Container -->
      <div class="flex-1 relative bg-slate-100">
        <div id="map"></div>
      </div>
    </div>

    <script>
      lucide.createIcons();

      // Kigali Coordinates
      const KIGALI_LAT = -1.9441;
      const KIGALI_LNG = 30.0619;

      // Initialize Map
      const map = L.map("map", {
        center: [KIGALI_LAT, KIGALI_LNG],
        zoom: 13,
        zoomControl: false,
      });

      // Add Zoom Control to bottom right
      L.control.zoom({ position: "bottomright" }).addTo(map);

      // Add OpenStreetMap Tiles
      L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
        attribution:
          '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
      }).addTo(map);

      // Mock Pharmacy Data
      const pharmacies = [
        {
          id: 1,
          name: "Kigali Life Pharmacy",
          lat: -1.945,
          lng: 30.062,
          address: "KN 2 Ave, Kigali",
          open: "24 Hours",
          rating: 4.8,
          stock: ["Amoxicillin", "Panadol", "Vitamins", "Insulin"],
          distance: "0.5 km",
        },
        {
          id: 2,
          name: "Remera Square Pharma",
          lat: -1.956,
          lng: 30.105,
          address: "KG 11 Ave, Remera",
          open: "08:00 - 22:00",
          rating: 4.5,
          stock: ["Ibuprofen", "Bandages", "Cough Syrup"],
          distance: "4.2 km",
        },
        {
          id: 3,
          name: "Nyarugenge Medical",
          lat: -1.94,
          lng: 30.058,
          address: "KN 4 St, Kigali",
          open: "07:00 - 20:00",
          rating: 4.2,
          stock: ["Antibiotics", "Painkillers", "Antimalarials"],
          distance: "0.8 km",
        },
        {
          id: 4,
          name: "Kacyiru Community Meds",
          lat: -1.935,
          lng: 30.08,
          address: "KG 563 St, Kacyiru",
          open: "08:00 - 20:00",
          rating: 4.6,
          stock: ["Paracetamol", "Amoxicillin", "First Aid Kits"],
          distance: "2.1 km",
        },
        {
          id: 5,
          name: "Gishushu Pharma Plus",
          lat: -1.95,
          lng: 30.095,
          address: "KG 7 Ave, Gishushu",
          open: "24 Hours",
          rating: 4.9,
          stock: ["Insulin", "Cardio Meds", "Vitamins"],
          distance: "3.5 km",
        },
      ];

      const markers = [];
      const pharmacyListEl = document.getElementById("pharmacy-list");
      const searchInput = document.getElementById("medicine-search");

      // Custom Icon
      const pharmacyIcon = L.divIcon({
        className: "custom-div-icon",
        html: `<div style="background-color: #0d9488; width: 32px; height: 32px; border-radius: 50%; border: 3px solid white; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1); display: flex; align-items: center; justify-content: center; color: white;">
                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-plus"><path d="M5 12h14"/><path d="M12 5v14"/></svg>
                   </div>`,
        iconSize: [32, 32],
        iconAnchor: [16, 16],
      });

      function renderPharmacies(filteredPharmacies) {
        // Clear list
        pharmacyListEl.innerHTML = "";

        // Clear markers
        markers.forEach((m) => map.removeLayer(m));
        markers.length = 0;

        if (filteredPharmacies.length === 0) {
          pharmacyListEl.innerHTML = `
                    <div class="text-center py-10">
                        <div class="bg-slate-100 p-4 rounded-full inline-block mb-3">
                            <i data-lucide="search-x" class="text-slate-400" width="32" height="32"></i>
                        </div>
                        <h3 class="text-slate-600 font-bold">No pharmacies found</h3>
                        <p class="text-slate-400 text-sm mt-1">Try searching for a different medicine.</p>
                    </div>
                `;
          lucide.createIcons();
          return;
        }

        filteredPharmacies.forEach((p) => {
          // Add Marker
          const marker = L.marker([p.lat, p.lng], { icon: pharmacyIcon }).addTo(
            map,
          ).bindPopup(`
                        <div class="font-sans">
                            <h3 class="font-bold text-teal-700 text-base mb-1">\${p.name}</h3>
                            <p class="text-slate-600 text-sm mb-2">\${p.address}</p>
                            <span class="inline-block bg-green-100 text-green-700 text-xs px-2 py-1 rounded-full font-bold">\${p.open}</span>
                        </div>
                    `);

          markers.push(marker);

          // Add List Item
          const item = document.createElement("div");
          item.className =
            "bg-white p-4 rounded-xl border border-slate-200 hover:border-teal-500 hover:shadow-md transition cursor-pointer group";
          item.innerHTML = `
                    <div class="flex justify-between items-start mb-2">
                        <h3 class="font-bold text-slate-800 group-hover:text-teal-700 transition">\${p.name}</h3>
                        <span class="flex items-center text-xs font-bold text-slate-500">
                            <i data-lucide="map-pin" width="12" class="mr-1"></i> \${p.distance}
                        </span>
                    </div>
                    <p class="text-xs text-slate-500 mb-3">\${p.address}</p>
                    <div class="flex flex-wrap gap-2 mb-3">
                        \${p.stock
                          .slice(0, 3)
                          .map(
                            (med) =>
                              `<span class="bg-slate-100 text-slate-600 text-xs px-2 py-0.5 rounded-md border border-slate-200">\${med}</span>`,
                          )
                          .join("")}
                        \${p.stock.length > 3 ? `<span class="text-xs text-slate-400">+\${p.stock.length - 3} more</span>` : ""}
                    </div>
                    <div class="flex items-center justify-between mt-2 pt-2 border-t border-slate-50">
                        <div class="flex items-center text-amber-500">
                            <i data-lucide="star" width="14" fill="currentColor"></i>
                            <span class="text-xs font-bold text-slate-700 ml-1">\${p.rating}</span>
                        </div>
                        <span class="text-xs font-medium text-green-600">\${p.open}</span>
                    </div>
                `;

          // Click event to fly to marker
          item.addEventListener("click", () => {
            map.flyTo([p.lat, p.lng], 16, { duration: 1.5 });
            marker.openPopup();
            // On mobile, close sidebar after selection
            if (window.innerWidth < 768) {
              document
                .getElementById("sidebar")
                .classList.add("-translate-x-full");
            }
          });

          pharmacyListEl.appendChild(item);
        });
        lucide.createIcons();
      }

      // Initial Render
      renderPharmacies(pharmacies);

      // Search Functionality
      searchInput.addEventListener("input", (e) => {
        const term = e.target.value.toLowerCase();
        const filtered = pharmacies.filter(
          (p) =>
            p.name.toLowerCase().includes(term) ||
            p.stock.some((s) => s.toLowerCase().includes(term)),
        );
        renderPharmacies(filtered);
      });

      // Toggle Sidebar Functionality (Mobile)
      document
        .getElementById("toggle-sidebar")
        .addEventListener("click", () => {
          const sidebar = document.getElementById("sidebar");
          sidebar.classList.toggle("-translate-x-full");
        });
    </script>
  </body>
</html>
