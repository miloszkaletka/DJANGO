from django.forms import ModelForm
from .models import Film, DodatkoweInfo, Ocena
from django import forms
from django.contrib.auth.forms import AuthenticationForm

class FilmForm(ModelForm):
    class Meta:
        model = Film
        fields = ['tytul','opis','premiera','rok','imdb_rating','plakat']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for name, field in self.fields.items():
            if name == 'plakat':
                field.widget.attrs['class'] = 'form-control-file'
            else:
                field.widget.attrs['class'] = 'form-control'   

    class LoginForm(AuthenticationForm):
        def __init__(self, *args, **kwargs):
            super().__init__(*args, **kwargs)

            # nadajemy bootstrapowe style
            for field in self.fields.values():
                field.widget.attrs.update({
                    'class': 'form-control form-control-lg mb-3',
                })

class DodatkoweInfoForm(ModelForm):
    class Meta:
        model = DodatkoweInfo
        fields = ['czas_trwania', 'gatunek']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for field in self.fields.values():
            field.widget.attrs.update({
                'class': 'form-control form-control-lg mb-3'
            })


class OcenaForm(ModelForm):
    class Meta:
        model = Ocena
        fields = ['gwiazdki', 'recenzja']