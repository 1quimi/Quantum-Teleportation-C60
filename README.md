# EGQV-4: Quantum Teleportation of C₆₀ Molecules

## 📜 Abstract
This project presents a complete theoretical and engineering design for the **quantum teleportation of a C₆₀ fullerene molecule** (mass 1.2×10⁻²⁴ kg). The system uses a cryogenic (10 mK) Paul trap, a high‑finesse optical cavity (ℱ > 10⁴), and an FPGA-based fast feedback loop (100 ns latency). The entanglement time is reduced to 5 ns, suppressing Raman scattering to <0.5 %. The calculated success probability per trial exceeds **93 %**.

## 📂 Files
- `paper_EGQV4.tex` – LaTeX source of the full article (all equations, figures, and references).
- `cavity_ctrl.vhd` – VHDL module for the piezo‑driven cavity control (200 MHz clock).
- `fpga_corrector.vhd` – VHDL module for the pulse correction logic (Bell measurement feedback).
- `ad9914_control.py` – Python driver for the AD9914 DDS (2.8 GHz microwaves).
- `calibration.py` – Spin‑echo calibration routine (simulates Raman scattering).

## 🚀 How to use
1. Compile the article:  
   ```bash
   pdflatex paper_EGQV4.tex
