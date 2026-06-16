#!/usr/bin/env python3
"""
Pulse calibration using spin‑echo simulation (includes Raman scattering model).
"""

import numpy as np
import matplotlib.pyplot as plt
from ad9914_control import AD9914
import time

def measure_echo(pulse_duration_ns, phase_deg):
    # Gaussian peak around 10 ns, penalty for duration >12 ns (scattering)
    fidelity = np.exp(- ((pulse_duration_ns - 10.0) ** 2) / 100.0)
    if pulse_duration_ns > 12:
        fidelity *= 0.9
    fidelity *= 0.5 * (1 + np.cos(np.radians(phase_deg)))
    return max(0.0, min(1.0, fidelity))

def calibrate_pulse():
    dds = AD9914()
    dds.set_frequency(2.8e9)
    durations = np.linspace(5, 20, 31)
    phases = [0, 90, 180, 270]
    results = {}
    for phase in phases:
        signals = []
        for dur in durations:
            dds.send_pulse(phase, dur)
            time.sleep(0.0005)
            s = measure_echo(dur, phase)
            signals.append(s)
        results[phase] = signals
    optimal = {}
    for phase, sig in results.items():
        idx = np.argmax(sig)
        optimal[phase] = durations[idx]
        print(f"Phase {phase}° -> optimal duration = {optimal[phase]:.1f} ns")
    dds.close()
    for phase, sig in results.items():
        plt.plot(durations, sig, label=f'{phase}°')
    plt.xlabel('Pulse duration (ns)')
    plt.ylabel('Echo fidelity')
    plt.legend()
    plt.title('Microwave pulse calibration (scattering suppressed)')
    plt.grid(True)
    plt.savefig('calibration.png')
    plt.show()
    return optimal

if __name__ == "__main__":
    calibrate_pulse()
