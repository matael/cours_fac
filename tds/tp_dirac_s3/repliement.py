#!/usr/bin/env python
# -*- coding: utf-8 -*-
from numpy import *
import wx

import matplotlib
matplotlib.interactive(False)
matplotlib.use('WXAgg')
from matplotlib.backends.backend_wxagg import FigureCanvasWxAgg
from matplotlib.figure import Figure
from matplotlib.pyplot import setp


class Knob:
    """
    Knob - Une simple classe avec une methode "setKnob".  
    Un instance Knob est liée à une instance Param, par ex. param.attach(knob)
    Cette classe de base ne sert QUE pour la documentation.
    """
    def setKnob(self, value):
        pass


class Param:
    """
    L'idée derrière la classe "Param" est que certains paramètres de l'interface peuvent posséder
    plusieurs contrôles qui à la fois le paramètrent et refletent l'état du paramètre, par ex.
    une glissière, un texte.  
    La classe propose une manière propre de donner un retour aux autres contrôles lorsque
    l'un d'eux est modifié. Cette classe prend également en charge les valeurs min et max
    des contrôles.
    L'idée est - une liste de contrôles 
      - dans la méthode "set" l'objet contrôle est également transmis
      - les autres contrôles de la liste de contrôles possèdent une méthode "setKnob" qui est appelée
    par les autres.
    """
    def __init__(self, initialValue=None, minimum=0., maximum=1.):
        self.minimum = minimum
        self.maximum = maximum
        if initialValue != self.constrain(initialValue):
            raise ValueError('Valeur initiale incorrecte')
        self.value = initialValue
        self.knobs = []
        
    def attach(self, knob):
        self.knobs += [knob]
#        print "KNOBS",self.knobs
        
    def set(self, value, knob=None):
        self.value = self.constrain(value)
        for feedbackKnob in self.knobs:
            if feedbackKnob != knob:
                feedbackKnob.setKnob(self.value)
        return self.value

    def constrain(self, value):
        if value <= self.minimum:
            value = self.minimum
        if value >= self.maximum:
            value = self.maximum
        return value


class SliderGroup(Knob):
    def __init__(self, parent, label, param):
        self.sliderLabel = wx.StaticText(parent, label=label)
        self.sliderText = wx.TextCtrl(parent, -1, style=wx.TE_PROCESS_ENTER)
        self.slider = wx.Slider(parent, -1)
        self.slider.SetMax(param.maximum*1000)
        self.setKnob(param.value)
        
        sizer = wx.BoxSizer(wx.HORIZONTAL)
        sizer.Add(self.sliderLabel, 0, wx.EXPAND | wx.ALIGN_CENTER | wx.ALL, border=2)
        sizer.Add(self.sliderText, 0, wx.EXPAND | wx.ALIGN_CENTER | wx.ALL, border=2)
        sizer.Add(self.slider, 1, wx.EXPAND)
        self.sizer = sizer

        self.slider.Bind(wx.EVT_SLIDER, self.sliderHandler)
        self.sliderText.Bind(wx.EVT_TEXT_ENTER, self.sliderTextHandler)

        self.param = param
        self.param.attach(self)

    def sliderHandler(self, evt):
        value = evt.GetInt() / 1000.
        self.param.set(value)
        
    def sliderTextHandler(self, evt):
        value = float(self.sliderText.GetValue())
        self.param.set(value)
        
    def setKnob(self, value):
        # sert à mettre à jour la glissière et la case du nombre
        self.sliderText.SetValue('%g'%value)
        self.slider.SetValue(value*1000)


class FourierDemoFrame(wx.Frame):
    def __init__(self, *args, **kwargs):
        wx.Frame.__init__(self, *args, **kwargs)

        self.fourierDemoWindow = FourierDemoWindow(self)
        # on ajoute un groupement de glissières
        self.frequencySliderGroup = SliderGroup(self, label=u'Fréquence Fo en Hz ', \
            param=self.fourierDemoWindow.f0)
        # on ajoute un groupement de glissières
        self.amplitudeSliderGroup = SliderGroup(self, label=' Amplitude A ', \
            param=self.fourierDemoWindow.A)
        # on ajoute un groupement de glissières
        self.phaseSliderGroup = SliderGroup(self, label='Phase phi en radian ', \
            param=self.fourierDemoWindow.phase)

        sizer = wx.BoxSizer(wx.VERTICAL)
        sizer.Add(self.fourierDemoWindow, 1, wx.EXPAND)
        sizer.Add(self.frequencySliderGroup.sizer, 0, \
            wx.EXPAND | wx.ALIGN_CENTER | wx.ALL, border=5)
        sizer.Add(self.amplitudeSliderGroup.sizer, 0, \
            wx.EXPAND | wx.ALIGN_CENTER | wx.ALL, border=5)
        sizer.Add(self.phaseSliderGroup.sizer, 0, \
            wx.EXPAND | wx.ALIGN_CENTER | wx.ALL, border=5)
        self.SetSizer(sizer)
        

class FourierDemoWindow(wx.Window, Knob):
    def __init__(self, *args, **kwargs):
        wx.Window.__init__(self, *args, **kwargs)
        self.lines = []
        self.figure = Figure()
        # espace vertical entre les subplots de la figure : hspace = height, wspace=width
        self.figure.subplots_adjust(hspace=0.6)
        self.canvas = FigureCanvasWxAgg(self, -1, self.figure)
        self.f0 = Param(1000., minimum=0., maximum=10000.)
        self.A = Param(1., minimum=0.01, maximum=2.)
        self.phase = Param(pi/4, minimum=-pi, maximum=pi)
        self.draw()

        self.f0.attach(self)
        self.A.attach(self)
        self.phase.attach(self)
        self.Bind(wx.EVT_SIZE, self.sizeHandler)
       
    def sizeHandler(self, *args, **kwargs):
        self.canvas.SetSize(self.GetSize())
       
    def draw(self):
        if not hasattr(self, 'subplot2'):
            self.subplot1 = self.figure.add_subplot(311)
            self.subplot2 = self.figure.add_subplot(312)
            self.subplot3 = self.figure.add_subplot(313)
        x1, y1, tREEL, yREEL, x2, y2, y3 = self.compute(self.f0.value, self.A.value, self.phase.value)
        color = (1., 0., 0.)
        self.lines += self.subplot1.plot(x1, y1, 'o-',color=color, linewidth=3)
        self.lines += self.subplot1.plot(tREEL, yREEL,color=(0.3,0.3,0.3), linewidth=1)
        self.lines += self.subplot2.plot(x2, y2, color=color, linewidth=2)
        self.lines += self.subplot3.plot(x2, y3, color=color, linewidth=2)
        #Set some plot attributes
        f0 = self.f0.value
        self.subplot1.set_title(u"Forme sinusoïdale échantillonnée à Fe = 5000 Hz", fontsize=12)
        self.subplot1.set_ylabel("Signal x(t)", fontsize = 8)
        self.subplot1.set_xlabel("Temps en seconde", fontsize = 8)
        self.subplot2.set_title(u"Transformée de Fourier", fontsize=12)
        self.subplot2.set_ylabel("Module de X(F)", fontsize = 8)
        self.subplot3.set_ylabel("Phase de X(F)", fontsize = 8)
        self.subplot3.set_xlabel(u"Fréquence en Hz", fontsize = 8)
#        self.subplot1.set_xlim([amin(x1), amax(x1)])
        self.subplot1.set_xlim([0, 20/f0])
        self.subplot1.set_ylim([-2.5,2.5])
        self.subplot2.set_xlim([amin(x2), amax(x2)])
        self.subplot2.set_ylim([amin(y2), amax(y2)])
        self.subplot3.set_xlim([amin(x2), amax(x2)])
        self.subplot3.set_ylim([amin(y3), amax(y3)])
        self.subplot1.text(0.05, .95, r'$x(t) = A \cdot \cos(2\pi F_0 t + phi)$', \
            verticalalignment='top', transform = self.subplot1.transAxes)
        self.subplot2.text(0.05, .95, r'$20 * \log_{10}(\left|X(F)\right|)$', \
            verticalalignment='top', transform = self.subplot2.transAxes)

    def compute(self, f0, A, phase):
        Fe = 5000
        N= 4096
        t = linspace(0,N-1,N)/Fe
        x = A*cos(2*pi*f0*t+phase)
# affichage du signal REEL sur 20 périodes !
        tREEL = linspace(0, 20/f0, 1024)
        yREEL = A*cos(2*pi*f0*tREEL+phase)
        #*exp(-300*pi*(t-t[N/2])**2)
        X = fft.fft(x)/N
        f = linspace(0,N-1,N)*Fe/N
        
        return t, x, tREEL, yREEL, f[:N/2-1], 20*log10(abs(X[:N/2-1])), angle(X[:N/2-1])#,deg=True)

    def repaint(self):
        self.canvas.draw()

    def setKnob(self, valeur):
        # Sert à mettre à jour les graphiques
        # l'argument valeur n'est pas utilisé
        x1, y1, tREEL, yREEL, x2, y2, y3 = self.compute(self.f0.value, self.A.value,self.phase.value)
#       self.subplot1.set_xlim([amin(x1), amax(x1)])
        f0 = self.f0.value
#       affichage du signal REEL sur 20 périodes !        
        self.subplot1.set_xlim([0, 20/f0])
        self.subplot1.set_ylim([-2.5,2.5])
        self.subplot2.set_xlim([amin(x2), amax(x2)])
        self.subplot2.set_ylim([amin(y2), amax(y2)])
        self.subplot3.set_xlim([amin(x2), amax(x2)])
        self.subplot3.set_ylim([amin(y3), amax(y3)])
        setp(self.lines[0], xdata=x1, ydata=y1)
        setp(self.lines[1], xdata=tREEL, ydata=yREEL)
        setp(self.lines[2], xdata=x2, ydata=y2)
        setp(self.lines[3], xdata=x2, ydata=y3)
        self.repaint()


class App(wx.App):
    def OnInit(self):
        self.frame1 = FourierDemoFrame(parent=None, title="Transformée de Fourier", size=(1280, 800))
        self.frame1.Show()
        return True
        
app = App()
app.MainLoop()
