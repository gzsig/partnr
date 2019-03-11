const previewImageOnFileSelect = () => {

  const inputs = document.querySelectorAll('.photo-input');
  if (inputs.length > 0) {
    for (const [i, input] of inputs.entries()) {
      input.addEventListener('change', () => {
        displayPreview(input, i);
      })
    };
  }
}

const displayPreview = (input, i) => {
  if (input.files && input.files[0]) {
    const reader = new FileReader();
    reader.onload = (event) => {
      document.getElementById(`photo-preview${i}`).src = event.currentTarget.result;
    }
    reader.readAsDataURL(input.files[0])
    document.getElementById(`photo-preview${i}`).classList.remove('d-none');
  }
}

export { previewImageOnFileSelect };
