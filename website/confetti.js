function createConfetti() {
    const confetti = document.createElement('div');
    confetti.classList.add('confetti');
    confetti.style.left = Math.random() * 100 + 'vw';
    confetti.style.animationDuration = Math.random() * 3 + 2 + 's'; // Randomized for effect
    document.body.appendChild(confetti);

    setTimeout(() => {
        confetti.remove();
    }, 3000); // Adjust to match the longest possible animation duration
}

setInterval(createConfetti, 300);
