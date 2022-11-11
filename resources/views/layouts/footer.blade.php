<!-- The footer needs to be redesigned -->
<footer id="footer" class="footer">
    <p>@ All rights reserved NotiNotes App</p>
    <p>Mateo Hernandez</p>
    <p>Aura Marcela</p>
</footer>


<script src="{{ url('js/navigation.js') }}"></script>
<script type="module">
    // Import the functions you need from the SDKs you need
    import { initializeApp } from "https://www.gstatic.com/firebasejs/9.14.0/firebase-app.js";
    import { getAnalytics } from "https://www.gstatic.com/firebasejs/9.14.0/firebase-analytics.js";

    const firebaseConfig = {
        apiKey: "{{config('services.firebase.apiKey')}}",
        authDomain: "{{config('services.firebase.authDomain')}}",
        projectId: "{{config('services.firebase.projectId')}}",
        storageBucket: "{{config('services.firebase.storageBucket')}}",
        messagingSenderId: "{{config('services.firebase.messagingSenderId')}}",
        appId: "{{config('services.firebase.appId')}}",
        measurementId: "{{config('services.firebase.measurementId')}}"
    };

    // Initialize Firebase
    const app = initializeApp(firebaseConfig);
    const analytics = getAnalytics(app);
</script>

</body>

</html>
