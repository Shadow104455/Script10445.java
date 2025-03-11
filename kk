// Unificação dos scripts Khanware
const ver = "V3.0.6";
const repoPath = "https://raw.githubusercontent.com/Niximkk/Khanware/refs/heads/main/";

let device = {
    mobile: /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini|Windows Phone|Mobile|Tablet|Kindle|Silk|PlayBook|BB10/i.test(navigator.userAgent),
    apple: /iPhone|iPad|iPod|Macintosh|Mac OS X/i.test(navigator.userAgent)
};

let user = {
    username: "Username",
    nickname: "Nickname",
    UID: 0
};

let loadedPlugins = [];

// Elementos da interface\const elements = {
    unloader: document.createElement('unloader'),
    dropdownMenu: document.createElement('dropDownMenu'),
    watermark: document.createElement('watermark'),
    statsPanel: document.createElement('statsPanel'),
    splashScreen: document.createElement('splashScreen')
};

// Configurações de funcionalidades\window.features = {
    questionSpoof: true,
    videoSpoof: true,
    showAnswers: false,
    autoAnswer: false,
    customBanner: false,
    nextRecomendation: false,
    repeatQuestion: false,
    minuteFarmer: false,
    rgbLogo: false
};

window.featureConfigs = {
    autoAnswerDelay: 3,
    customUsername: "",
    customPfp: ""
};

// Segurança
const preventDebug = () => {
    document.addEventListener('contextmenu', e => e.preventDefault());
    document.addEventListener('keydown', e => {
        if (e.key === 'F12' || (e.ctrlKey && e.shiftKey && /[ICJ]/.test(e.key))) e.preventDefault();
    });
    console.log(Object.defineProperties(new Error, { 
        toString: { value() { (new Error).stack.includes('toString@') && location.reload(); }}, 
        message: { get() { location.reload(); }}
    }));
};

// Funções utilitárias
const delay = ms => new Promise(resolve => setTimeout(resolve, ms));
const playAudio = url => { const audio = new Audio(url); audio.play(); };
const findAndClickByClass = className => { const element = document.querySelector(`.${className}`); if (element) element.click(); };

function sendToast(text, duration = 5000) {
    Toastify({ text, duration, gravity: 'bottom', position: 'center', style: { background: '#000' }}).showToast();
}

// Splash Screen
async function showSplashScreen() {
    elements.splashScreen.style.cssText = "position:fixed;top:0;left:0;width:100%;height:100%;background-color:#000;display:flex;align-items:center;justify-content:center;z-index:9999;opacity:0;transition:opacity 0.5s ease;user-select:none;color:white;font-family:MuseoSans,sans-serif;font-size:30px;text-align:center;";
    elements.splashScreen.innerHTML = '<span style="color:white;">KHANWARE</span><span style="color:#72ff72;">.SPACE</span>';
    document.body.appendChild(elements.splashScreen);
    setTimeout(() => elements.splashScreen.style.opacity = '1', 10);
}

async function hideSplashScreen() {
    elements.splashScreen.style.opacity = '0';
    setTimeout(() => elements.splashScreen.remove(), 1000);
}

// Carregamento de scripts e estilos
async function loadScript(url, label) {
    return fetch(url).then(res => res.text()).then(script => { loadedPlugins.push(label); eval(script); });
}

async function loadCss(url) {
    return new Promise(resolve => {
        const link = document.createElement('link');
        link.rel = 'stylesheet';
        link.href = url;
        link.onload = resolve;
        document.head.appendChild(link);
    });
}

// Configuração principal
function setupMain() {
    loadScript(repoPath + 'functions/questionSpoof.js', 'questionSpoof');
    loadScript(repoPath + 'functions/videoSpoof.js', 'videoSpoof');
    loadScript(repoPath + 'functions/autoAnswer.js', 'autoAnswer');
}

// Injeção
if (!/^https?:\/\/([a-z0-9-]+\.)?khanacademy\.org/.test(window.location.href)) {
    alert("❌ Khanware Failed to Injected!\n\nAcesse o site correto: https://pt.khanacademy.org/");
    window.location.href = "https://pt.khanacademy.org/";
}

showSplashScreen();
preventDebug();

// Carregando recursos externos
Promise.all([
    loadScript('https://raw.githubusercontent.com/adryd325/oneko.js/refs/heads/main/oneko.js', 'onekoJs'),
    loadScript('https://cdn.jsdelivr.net/npm/darkreader@4.9.92/darkreader.min.js', 'darkReaderPlugin'),
    loadCss('https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css'),
    loadScript('https://cdn.jsdelivr.net/npm/toastify-js', 'toastifyPlugin')
]).then(() => {
    DarkReader.enable();
    setupMain();
    hideSplashScreen();
});

console.log('✅ Khanware Injected Successfully!');
