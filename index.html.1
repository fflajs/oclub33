<!DOCTYPE html>
<html lang="hr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Flaviov Kvantni Simulator</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Three.js for 3D Bloch Spheres -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
    <style>
        body {
            overscroll-behavior-y: contain;
            touch-action: manipulation;
        }
        .circuit-grid {
            background-image: linear-gradient(to right, #e5e7eb 1px, transparent 1px);
            background-size: 60px 100%;
        }
        .wire {
            position: relative;
            height: 60px;
            display: flex;
            align-items: center;
        }
        .wire::before {
            content: '';
            position: absolute;
            left: 0;
            right: 0;
            top: 50%;
            height: 2px;
            background-color: #9ca3af;
            z-index: 0;
        }
        .gate-slot {
            width: 50px;
            height: 50px;
            margin-left: 10px;
            z-index: 10;
            display: flex;
            justify-content: center;
            align-items: center;
            border: 2px dashed transparent;
            border-radius: 4px;
            transition: all 0.2s;
        }
        .gate-slot.drag-over {
            background-color: rgba(167, 243, 208, 0.5);
            border-color: #10b981;
        }
        .gate {
            width: 44px;
            height: 44px;
            border-radius: 4px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-weight: bold;
            color: white;
            cursor: grab;
            user-select: none;
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
            font-size: 0.8rem;
            touch-action: none; 
        }
        .gate:active { cursor: grabbing; }
        .gate-H { background-color: #3b82f6; }
        .gate-X { background-color: #ef4444; }
        .gate-Z { background-color: #10b981; }
        .gate-CX { background-color: #8b5cf6; font-size: 0.7rem;}
        
        .result-bar-container {
            display: flex;
            align-items: center;
            margin-bottom: 4px;
            font-size: 0.8rem;
        }
        .result-bar {
            height: 20px;
            background-color: #6366f1;
            border-radius: 2px;
            transition: width 0.5s ease;
        }
        .qubit-label {
            font-family: monospace;
            width: 40px;
            flex-shrink: 0;
            text-align: center;
            font-weight: bold;
            color: #4b5563;
        }
        /* Bloch Sphere Containers */
        .bloch-wrapper {
            position: relative;
            width: 150px;
            height: 180px;
            display: flex;
            flex-direction: column;
            align-items: center;
            background: #1f2937; /* Gray 800 */
            border-radius: 8px;
            padding: 5px;
        }
        .bloch-canvas-container {
            width: 140px;
            height: 140px;
        }
        canvas { outline: none; }
    </style>
</head>
<body class="bg-gray-50 text-gray-800 h-screen flex flex-col font-sans">

    <!-- Header -->
    <header class="bg-white shadow-sm p-4 flex flex-col gap-3 z-20 relative">
        <div class="flex justify-between items-center">
            <div>
                <h1 id="lbl-title" class="text-lg font-bold text-indigo-700">Kvantni Laboratorij</h1>
                <p id="lbl-subtitle" class="text-xs text-gray-500">4 Qubita • Drag & Drop</p>
            </div>
            <select id="lang-selector" onchange="changeLanguage(this.value)" class="text-sm border border-gray-300 rounded px-2 py-1 bg-gray-50 text-gray-700 focus:outline-none focus:border-indigo-500">
                <option value="hr">🇭🇷 HR</option>
                <option value="sr">🇷🇸 SR</option>
                <option value="en">🇬🇧 EN</option>
                <option value="de">🇩🇪 DE</option>
            </select>
        </div>

        <div class="flex flex-wrap gap-2 items-center justify-between bg-gray-50 p-2 rounded border border-gray-200">
             <div class="flex items-center gap-2 mb-2 sm:mb-0">
                <span id="lbl-examples" class="text-xs font-bold text-gray-500 uppercase">Primjeri:</span>
                <select id="example-selector" onchange="loadExample(this.value)" class="text-xs border border-gray-300 rounded px-2 py-1 bg-white text-gray-700 focus:outline-none focus:border-indigo-500">
                    <option value="" id="opt-choose">- Odaberi -</option>
                    <option value="superposition">Superpozicija</option>
                    <option value="entanglement">Sprega (Bell)</option>
                    <option value="ghz">GHZ Stanje (3-Qubit)</option>
                </select>
             </div>

             <div class="flex gap-2 w-full sm:w-auto justify-end">
                <!-- Toggle Bloch Button -->
                <button id="btn-bloch" onclick="toggleBloch()" class="px-3 py-1 text-xs font-bold bg-indigo-100 text-indigo-700 border border-indigo-200 hover:bg-indigo-200 rounded transition">BLOCH: UKLJ</button>
                
                <button id="btn-clear" onclick="resetCircuit()" class="px-3 py-1 text-xs font-bold bg-gray-200 hover:bg-gray-300 rounded transition text-gray-600">OČISTI</button>
                <button id="btn-sim" onclick="runSimulation()" class="px-3 py-1 text-xs font-bold bg-indigo-600 text-white hover:bg-indigo-700 rounded shadow transition">SIMULIRAJ ▶</button>
            </div>
        </div>
    </header>

    <!-- Palette -->
    <div class="bg-gray-100 p-3 border-b border-gray-200 flex gap-4 overflow-x-auto items-center justify-start sm:justify-center shadow-inner z-20 relative">
        <span id="lbl-gates" class="text-xs font-bold text-gray-400 uppercase mr-2">Vrata:</span>
        <div class="gate gate-H" data-type="H" onpointerdown="startDrag(event, 'H')">H</div>
        <div class="gate gate-X" data-type="X" onpointerdown="startDrag(event, 'X')">X</div>
        <div class="gate gate-Z" data-type="Z" onpointerdown="startDrag(event, 'Z')">Z</div>
        <div class="gate gate-CX" data-type="CX" onpointerdown="startDrag(event, 'CX')">CX↓</div>
    </div>

    <!-- Main Content: Split View (Circuit & Bloch) -->
    <div class="flex-1 overflow-hidden flex flex-col lg:flex-row relative bg-white">
        
        <!-- Circuit Editor -->
        <div class="flex-1 overflow-auto border-b lg:border-b-0 lg:border-r border-gray-200" id="circuit-container">
            <div class="min-w-[600px] p-4 circuit-grid" id="circuit-board"></div>
        </div>

        <!-- Bloch Spheres Display (With ID for toggling) -->
        <div id="bloch-panel" class="h-[220px] lg:h-auto lg:w-[340px] bg-gray-900 p-2 overflow-x-auto lg:overflow-y-auto flex lg:flex-col gap-2 items-center justify-start shadow-inner z-10">
             <!-- generated by JS -->
             <div id="bloch-container" class="flex lg:flex-col gap-2"></div>
        </div>
    </div>

    <!-- Probabilities Footer -->
    <div class="h-1/4 bg-gray-800 text-white p-4 overflow-y-auto border-t border-gray-700 z-20 relative">
        <h3 id="lbl-results" class="text-sm font-bold text-gray-400 mb-2 sticky top-0 bg-gray-800 pb-2 border-b border-gray-700">
            REZULTATI MJERENJA
        </h3>
        <div id="results-display" class="space-y-1">
            <p id="lbl-empty-msg" class="text-gray-500 text-sm italic">Dodaj vrata i pritisni 'Simuliraj'...</p>
        </div>
    </div>

    <div id="drag-ghost" class="gate fixed pointer-events-none hidden opacity-80 z-50 shadow-xl ring-2 ring-white"></div>

<script>
    // --- 0. MULTILINGUAL & CONFIG ---
    
    const TRANSLATIONS = {
        hr: {
            title: "Kvantni Laboratorij",
            subtitle: "4 Qubita • Drag & Drop",
            clear: "OČISTI",
            simulate: "SIMULIRAJ ▶",
            gates: "Vrata:",
            results: "REZULTATI MJERENJA (Vjerojatnosti)",
            emptyMsg: "Dodaj vrata i pritisni 'Simuliraj'...",
            clearedMsg: "Ploča očišćena.",
            examples: "PRIMJERI:",
            optChoose: "- Odaberi -",
            optSuper: "Superpozicija",
            optEntang: "Sprega (Bell)",
            optGhz: "GHZ Stanje (3-Qubit)",
            bloch: "Bloch Sfera",
            blochOn: "BLOCH: UKLJ",
            blochOff: "BLOCH: ISKLJ"
        },
        sr: {
            title: "Kvantna Laboratorija",
            subtitle: "4 Kubita • Drag & Drop",
            clear: "OČISTI",
            simulate: "SIMULIRAJ ▶",
            gates: "Kapije:",
            results: "REZULTATI MERENJA (Verovatnoće)",
            emptyMsg: "Dodaj kapije i pritisni 'Simuliraj'...",
            clearedMsg: "Ploča očišćena.",
            examples: "PRIMERI:",
            optChoose: "- Izaberi -",
            optSuper: "Superpozicija",
            optEntang: "Sprega (Bell)",
            optGhz: "GHZ Stanje (3-Qubit)",
            bloch: "Bloch Sfera",
            blochOn: "BLOCH: UKLJ",
            blochOff: "BLOCH: ISKLJ"
        },
        en: {
            title: "Quantum Laboratory",
            subtitle: "4 Qubits • Drag & Drop",
            clear: "CLEAR",
            simulate: "SIMULATE ▶",
            gates: "Gates:",
            results: "MEASUREMENT RESULTS (Probabilities)",
            emptyMsg: "Add gates and press 'Simulate'...",
            clearedMsg: "Circuit cleared.",
            examples: "EXAMPLES:",
            optChoose: "- Choose -",
            optSuper: "Superposition",
            optEntang: "Entanglement (Bell)",
            optGhz: "GHZ State (3-Qubit)",
            bloch: "Bloch Sphere",
            blochOn: "BLOCH: ON",
            blochOff: "BLOCH: OFF"
        },
        de: {
            title: "Quantenlabor",
            subtitle: "4 Qubits • Drag & Drop",
            clear: "LÖSCHEN",
            simulate: "SIMULIEREN ▶",
            gates: "Gatter:",
            results: "MESSERGEBNISSE (Wahrscheinlichkeiten)",
            emptyMsg: "Gatter hinzufügen und 'Simulieren' drücken...",
            clearedMsg: "Schaltkreis gelöscht.",
            examples: "BEISPIELE:",
            optChoose: "- Wählen -",
            optSuper: "Superposition",
            optEntang: "Verschränkung (Bell)",
            optGhz: "GHZ-Zustand (3-Qubit)",
            bloch: "Bloch-Kugel",
            blochOn: "BLOCH: AN",
            blochOff: "BLOCH: AUS"
        }
    };

    let currentLang = 'hr';
    let blochVisible = true;

    function changeLanguage(lang) {
        currentLang = lang;
        const t = TRANSLATIONS[lang];
        document.getElementById('lbl-title').innerText = t.title;
        document.getElementById('lbl-subtitle').innerText = t.subtitle;
        document.getElementById('btn-clear').innerText = t.clear;
        document.getElementById('btn-sim').innerText = t.simulate;
        document.getElementById('lbl-gates').innerText = t.gates;
        document.getElementById('lbl-results').innerText = t.results;
        document.getElementById('lbl-examples').innerText = t.examples;
        document.getElementById('opt-choose').innerText = t.optChoose;
        document.querySelector('option[value="superposition"]').innerText = t.optSuper;
        document.querySelector('option[value="entanglement"]').innerText = t.optEntang;
        document.querySelector('option[value="ghz"]').innerText = t.optGhz;
        
        updateBlochButtonText();

        document.querySelectorAll('.bloch-label').forEach((el, idx) => {
            el.textContent = `q[${idx}] ${t.bloch}`;
        });

        const resultsDisplay = document.getElementById('results-display');
        if (resultsDisplay.innerHTML.includes('italic')) {
             resultsDisplay.innerHTML = `<p class="text-gray-500 text-sm italic">${t.emptyMsg}</p>`;
        }
    }

    function toggleBloch() {
        blochVisible = !blochVisible;
        const panel = document.getElementById('bloch-panel');
        const btn = document.getElementById('btn-bloch');
        
        if (blochVisible) {
            panel.classList.remove('hidden');
            panel.classList.add('flex');
            
            // Change button style to active (indigo)
            btn.classList.remove('bg-gray-200', 'text-gray-600');
            btn.classList.add('bg-indigo-100', 'text-indigo-700', 'border-indigo-200');
            
            // Re-render Three.js scenes after a slight delay to ensure container has size
            setTimeout(() => {
                initBlochSpheres();
                simulate();
            }, 50);
        } else {
            panel.classList.add('hidden');
            panel.classList.remove('flex');
            
            // Change button style to inactive (gray)
            btn.classList.remove('bg-indigo-100', 'text-indigo-700', 'border-indigo-200');
            btn.classList.add('bg-gray-200', 'text-gray-600');
        }
        updateBlochButtonText();
    }

    function updateBlochButtonText() {
        const t = TRANSLATIONS[currentLang];
        const btn = document.getElementById('btn-bloch');
        btn.innerText = blochVisible ? t.blochOn : t.blochOff;
    }

    // --- 1. QUANTUM LOGIC ENGINE ---
    
    class Complex {
        constructor(re, im) { this.re = re; this.im = im; }
        add(c) { return new Complex(this.re + c.re, this.im + c.im); }
        mul(c) { return new Complex(this.re * c.re - this.im * c.im, this.re * c.im + this.im * c.re); }
        magSq() { return this.re * this.re + this.im * this.im; }
    }

    const NUM_QUBITS = 4;
    const STATE_SIZE = Math.pow(2, NUM_QUBITS);
    const NUM_STEPS = 8;

    let stateVector = new Array(STATE_SIZE).fill(null).map((_, i) => i === 0 ? new Complex(1, 0) : new Complex(0, 0));

    const GATES = {
        'H': [[new Complex(1/Math.sqrt(2),0), new Complex(1/Math.sqrt(2),0)], [new Complex(1/Math.sqrt(2),0), new Complex(-1/Math.sqrt(2),0)]],
        'X': [[new Complex(0,0), new Complex(1,0)], [new Complex(1,0), new Complex(0,0)]],
        'Z': [[new Complex(1,0), new Complex(0,0)], [new Complex(0,0), new Complex(-1,0)]],
        'I': [[new Complex(1,0), new Complex(0,0)], [new Complex(0,0), new Complex(1,0)]]
    };

    let circuitState = Array(NUM_QUBITS).fill().map(() => Array(NUM_STEPS).fill(null));

    function simulate() {
        stateVector = new Array(STATE_SIZE).fill(null).map((_, i) => i === 0 ? new Complex(1, 0) : new Complex(0, 0));

        for (let step = 0; step < NUM_STEPS; step++) {
            let stepOps = [];
            for(let q=0; q<NUM_QUBITS; q++) {
                if (circuitState[q][step]) {
                    stepOps.push({ qubit: q, type: circuitState[q][step] });
                }
            }

            stepOps.forEach(op => {
                let newState = new Array(STATE_SIZE).fill(null).map(() => new Complex(0,0));
                if (op.type === 'CX') {
                    let control = op.qubit;
                    let target = op.qubit + 1;
                    if (target < NUM_QUBITS) {
                        for (let i = 0; i < STATE_SIZE; i++) {
                            let controlBit = (i >> (NUM_QUBITS - 1 - control)) & 1;
                            if (controlBit === 1) {
                                let mask = 1 << (NUM_QUBITS - 1 - target);
                                newState[i] = stateVector[i ^ mask];
                            } else {
                                newState[i] = stateVector[i];
                            }
                        }
                        stateVector = newState;
                    }
                } 
                else {
                    let gateM = GATES[op.type];
                    for (let i = 0; i < STATE_SIZE; i++) {
                         if ( ((i >> (NUM_QUBITS - 1 - op.qubit)) & 1) === 0 ) {
                             let idx0 = i;
                             let idx1 = i | (1 << (NUM_QUBITS - 1 - op.qubit));
                             let amp0 = stateVector[idx0];
                             let amp1 = stateVector[idx1];
                             
                             let new0 = amp0.mul(gateM[0][0]).add(amp1.mul(gateM[0][1]));
                             let new1 = amp0.mul(gateM[1][0]).add(amp1.mul(gateM[1][1]));
                             newState[idx0] = new0;
                             newState[idx1] = new1;
                         }
                    }
                    stateVector = newState;
                }
            });
        }
        renderResults();
        if (blochVisible) {
            updateBlochSpheres();
        }
    }

    // --- 2. THREE.JS BLOCH SPHERE ENGINE ---
    
    let spheres = []; // Stores { renderer, scene, camera, arrow } for each qubit

    function initBlochSpheres() {
        const container = document.getElementById('bloch-container');
        container.innerHTML = '';
        spheres = [];

        for(let i=0; i<NUM_QUBITS; i++) {
            // Wrapper
            let wrap = document.createElement('div');
            wrap.className = 'bloch-wrapper';
            
            let label = document.createElement('div');
            label.className = 'text-xs text-gray-300 mb-1 font-mono bloch-label';
            label.innerText = `q[${i}] Bloch Sfera`;
            wrap.appendChild(label);

            let canvasBox = document.createElement('div');
            canvasBox.className = 'bloch-canvas-container';
            wrap.appendChild(canvasBox);
            
            container.appendChild(wrap);

            // Three JS Setup
            const width = 140;
            const height = 140;
            const scene = new THREE.Scene();
            scene.background = new THREE.Color(0x1f2937); // Matches bg-gray-800

            const camera = new THREE.PerspectiveCamera(50, width / height, 0.1, 1000);
            camera.position.z = 2.2;
            camera.position.y = 0.5;
            camera.lookAt(0,0,0);

            const renderer = new THREE.WebGLRenderer({ antialias: true });
            renderer.setSize(width, height);
            canvasBox.appendChild(renderer.domElement);

            // Sphere (Wireframe)
            const geometry = new THREE.SphereGeometry(1, 16, 16);
            const material = new THREE.MeshBasicMaterial({ color: 0x4b5563, wireframe: true, transparent: true, opacity: 0.3 });
            const sphere = new THREE.Mesh(geometry, material);
            scene.add(sphere);

            // Axes
            const axesHelper = new THREE.AxesHelper(1.2);
            scene.add(axesHelper);

            // Arrow (The State)
            const dir = new THREE.Vector3(0, 1, 0); // Starts at |0> (North pole)
            const origin = new THREE.Vector3(0, 0, 0);
            const length = 1;
            const hex = 0x6366f1; // Indigo
            const arrowHelper = new THREE.ArrowHelper(dir, origin, length, hex, 0.2, 0.1);
            scene.add(arrowHelper);
            
            spheres.push({ renderer, scene, camera, arrow: arrowHelper });
            renderer.render(scene, camera);
        }
    }

    function updateBlochSpheres() {
        // Only run if spheres array is populated (panel is visible)
        if (spheres.length === 0) return;
        
        for(let q=0; q<NUM_QUBITS; q++) {
            let rx = 0, ry = 0, rz = 0;
            
            for(let i=0; i<STATE_SIZE; i++) {
                let b = (i >> (NUM_QUBITS - 1 - q)) & 1;
                if (b === 0) {
                    let j = i | (1 << (NUM_QUBITS - 1 - q));
                    let c0 = stateVector[i];
                    let c1 = stateVector[j];
                    
                    let mag0 = c0.magSq();
                    let mag1 = c1.magSq();
                    
                    rz += (mag0 - mag1);
                    
                    let realPart = c0.re * c1.re + c0.im * c1.im;
                    let imPart = c0.im * c1.re - c0.re * c1.im;
                    
                    rx += 2 * realPart;
                    ry += 2 * imPart;
                }
            }

            const arrow = spheres[q].arrow;
            let len = Math.sqrt(rx*rx + ry*ry + rz*rz);
            if (len < 0.01) len = 0.01; 
            
            const dir = new THREE.Vector3(rx, rz, ry).normalize(); 
            
            arrow.setDirection(dir);
            arrow.setLength(Math.min(len, 1.0), 0.2, 0.1); 
            
            if (len < 0.9) {
                arrow.setColor(0xff5555);
            } else {
                arrow.setColor(0x6366f1);
            }
            
            spheres[q].renderer.render(spheres[q].scene, spheres[q].camera);
        }
    }

    // --- 3. UI & BOARD LOGIC ---

    const board = document.getElementById('circuit-board');

    function initBoard() {
        board.innerHTML = '';
        for (let i = 0; i < NUM_QUBITS; i++) {
            const row = document.createElement('div');
            row.className = 'wire';
            
            const label = document.createElement('div');
            label.className = 'qubit-label';
            label.textContent = `q[${i}]`;
            row.appendChild(label);

            for (let j = 0; j < NUM_STEPS; j++) {
                const slot = document.createElement('div');
                slot.className = 'gate-slot';
                slot.dataset.q = i;
                slot.dataset.s = j;
                
                if (circuitState[i][j]) {
                    const gate = document.createElement('div');
                    gate.className = `gate gate-${circuitState[i][j]}`;
                    gate.textContent = circuitState[i][j] === 'CX' ? 'CX↓' : circuitState[i][j];
                    gate.onpointerdown = (e) => { e.stopPropagation(); removeGate(i, j); };
                    slot.appendChild(gate);
                }
                
                slot.onpointerup = (e) => handleDrop(e, i, j);
                row.appendChild(slot);
            }
            board.appendChild(row);
        }
    }

    // --- DRAG AND DROP ---
    let draggedType = null;
    let isDragging = false;
    const ghost = document.getElementById('drag-ghost');

    function startDrag(e, type) {
        e.preventDefault();
        isDragging = true;
        draggedType = type;
        ghost.className = `gate gate-${type} fixed pointer-events-none opacity-80 z-50 shadow-xl`;
        ghost.textContent = type === 'CX' ? 'CX↓' : type;
        ghost.style.display = 'flex';
        moveGhost(e);
        document.addEventListener('pointermove', moveGhost);
        document.addEventListener('pointerup', endDrag);
    }

    function moveGhost(e) {
        if (!isDragging) return;
        ghost.style.left = (e.clientX - 22) + 'px';
        ghost.style.top = (e.clientY - 22) + 'px';
        document.querySelectorAll('.gate-slot').forEach(slot => slot.classList.remove('drag-over'));
        const slot = document.elementFromPoint(e.clientX, e.clientY)?.closest('.gate-slot');
        if (slot) slot.classList.add('drag-over');
    }

    function endDrag(e) {
        isDragging = false;
        ghost.style.display = 'none';
        document.removeEventListener('pointermove', moveGhost);
        document.removeEventListener('pointerup', endDrag);
        document.querySelectorAll('.gate-slot').forEach(slot => slot.classList.remove('drag-over'));
        const slot = document.elementFromPoint(e.clientX, e.clientY)?.closest('.gate-slot');
        if (slot) placeGate(parseInt(slot.dataset.q), parseInt(slot.dataset.s), draggedType);
    }

    function handleDrop(e, q, s) { }

    function placeGate(q, s, type) {
        circuitState[q][s] = type;
        initBoard();
    }

    function removeGate(q, s) {
        circuitState[q][s] = null;
        initBoard();
    }

    function resetCircuit() {
        circuitState = Array(NUM_QUBITS).fill().map(() => Array(NUM_STEPS).fill(null));
        const msg = TRANSLATIONS[currentLang].clearedMsg;
        document.getElementById('results-display').innerHTML = `<p class="text-gray-500 text-sm italic">${msg}</p>`;
        initBoard();
        document.getElementById('example-selector').value = "";
        simulate(); 
    }
    
    function loadExample(type) {
        if (!type) return;
        circuitState = Array(NUM_QUBITS).fill().map(() => Array(NUM_STEPS).fill(null));
        
        if (type === 'superposition') {
            circuitState[0][0] = 'H';
        } else if (type === 'entanglement') {
            circuitState[0][0] = 'H';
            circuitState[0][1] = 'CX'; 
        } else if (type === 'ghz') {
            circuitState[0][0] = 'H';
            circuitState[0][1] = 'CX';
            circuitState[1][2] = 'CX';
        }
        
        initBoard();
        simulate();
    }

    function runSimulation() {
        simulate();
    }

    function renderResults() {
        const container = document.getElementById('results-display');
        container.innerHTML = '';
        let results = [];
        for(let i=0; i<STATE_SIZE; i++) {
            let prob = stateVector[i].magSq();
            if (prob > 0.001) results.push({ index: i, prob: prob });
        }
        if (results.length === 0) results.push({index: 0, prob: 1});

        results.forEach(res => {
            let binary = res.index.toString(2).padStart(NUM_QUBITS, '0');
            let percentage = (res.prob * 100).toFixed(1);
            const row = document.createElement('div');
            row.className = 'result-bar-container';
            row.innerHTML = `
                <div class="w-12 font-mono text-xs text-gray-400">|${binary}⟩</div>
                <div class="flex-1 mx-2 bg-gray-700 rounded h-5 relative overflow-hidden">
                    <div class="result-bar bg-indigo-500 h-full" style="width: ${percentage}%"></div>
                    <span class="absolute inset-0 flex items-center pl-2 text-xs text-white shadow-black drop-shadow-md">${percentage}%</span>
                </div>
            `;
            container.appendChild(row);
        });
    }

    // Init
    initBlochSpheres();
    initBoard();
    changeLanguage('hr');
    simulate(); 

    // Handle Window Resize for Three.js
    window.addEventListener('resize', () => {
        if (blochVisible) {
            initBlochSpheres();
            simulate();
        }
    });

</script>
</body>
</html>
