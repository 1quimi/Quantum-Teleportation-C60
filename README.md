# EGQV-7: Spin-Mechanical Entanglement of a Levitated Nanodiamond

## 📜 Abstract
Realistic experimental proposal to generate entanglement between the center-of-mass motion of a diamond nanoparticle (100 nm) and an ensemble of NV centers (~10³ spins).

The system uses:
- Cryogenic Paul trap (10 mK)
- Optimized magnetic gradient (10⁶ T/m)
- FPGA with 100 ns feedback
- VHDL and Python code for microwave control and calibration

**New**: The timing gap was resolved by increasing $g_0$ to 3.2 kHz, resulting in $\tau_{\text{ent}} = 50$ µs, less than the coherence time.

## 📂 Files
- `EGQV7.tex` – complete LaTeX article
- `cavity_ctrl.vhd` – piezo cavity control
- `fpga_corrector.vhd` – pulse correction logic
- `ad9914_control.py` – AD9914 driver
- `calibration.py` – pulse calibration

## 🚀 How to use
1. Compile the article: `pdflatex EGQV7.tex` (twice)
2. Synthesize VHDL in Vivado
3. Connect AD9914 via SPI and run `python ad9914_control.py`
4. Calibrate: `python calibration.py`

## ⚖️ License
MIT
