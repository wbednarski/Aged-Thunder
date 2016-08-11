export const Image = {

  init() {
    let input = document.getElementById('image_attachment'); // TODO Fix phoenix naming from _ to -
    if (input) {
      input.addEventListener('change', (e) => this.readURL(e.target));  
    }
  },

  readURL(input) {
    if (input.files && input.files[0]) {
      let reader = new FileReader();

      reader.onload = e => {
        let image = document.getElementById('image-preview');
        image.src = e.target.result;
      }

      reader.readAsDataURL(input.files[0]);
    }
  }

}
