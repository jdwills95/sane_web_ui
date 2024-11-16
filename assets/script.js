document.addEventListener("DOMContentLoaded", function() {
    const themeToggleBtn = document.getElementById("theme-toggle");
    const prefersDarkScheme = window.matchMedia("(prefers-color-scheme: dark)");
    const overlay = document.getElementById("overlay");
    const loadingSpinner = document.getElementById("loadingSpinner");
    const scanButton = document.getElementById("scanButton");

    // Function to switch themes
    function toggleTheme() {
        document.body.classList.toggle("light-mode");

        // Save the user's preference in localStorage
        if (document.body.classList.contains("light-mode")) {
            localStorage.setItem("theme", "light");
            themeToggleBtn.textContent = "🌙"; // Moon icon (for switching to dark)
        } else {
            localStorage.setItem("theme", "dark");
            themeToggleBtn.textContent = "🌞"; // Sun icon (for switching to light)
        }
    }

    // Check localStorage for theme preference
    const savedTheme = localStorage.getItem("theme");
    if (savedTheme) {
        // Apply saved theme and adjust the button icon
        if (savedTheme === "light") {
            document.body.classList.add("light-mode");
            themeToggleBtn.textContent = "🌙"; // Moon icon (for switching to dark)
        } else {
            document.body.classList.remove("light-mode");
            themeToggleBtn.textContent = "🌞"; // Sun icon (for switching to light)
        }
    } else if (prefersDarkScheme.matches) {
        // Default to dark theme if no saved preference and system prefers dark
        document.body.classList.remove("light-mode");
        themeToggleBtn.textContent = "🌞"; // Moon icon (for switching to dark)
    } else {
        // Default to light theme if no saved preference and system prefers light
        document.body.classList.add("light-mode");
        themeToggleBtn.textContent = "🌙"; // Sun icon (for switching to light)
    }

    // Listen for theme toggle button click
    themeToggleBtn.addEventListener("click", toggleTheme);

    // Handle the form submission to show the spinner and disable the button
    const scanForm = document.getElementById("scanForm");

    scanForm.onsubmit = function(event) {
        // Prevent form submission from immediately navigating
        event.preventDefault();

        // Show the overlay and spinner
        overlay.style.display = "block";
        loadingSpinner.style.display = "block";
        scanButton.disabled = true;

        // Simulate a form submission using fetch or Ajax (if needed for async handling)
        setTimeout(function() {
            scanForm.submit();  // Submit the form after simulating loading time
        }, 1500);  // 1.5 seconds delay for demonstration purposes
    };
});
