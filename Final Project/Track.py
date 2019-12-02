import hdf5_getters
import tables
import numpy as np

class Track:
    def __init__(self, trackId, h5):
        self.trackId = trackId
        self.h5 = h5 
        self.genre = "Others"
        self.tempo = 0
    
    def setGenre(self, genre):
        self.genre=genre
        
    def extractFeatures(self):
        with hdf5_getters.open_h5_file_read(self.h5) as h5:
            self.tempo = hdf5_getters.get_tempo(h5,0)
            ## Select the first 20 segments of the song
            self.segments_start = hdf5_getters.get_segments_start(h5)[0:20]
            ## Each segment has 12 timbre coeffs
            self.segments_timbre = hdf5_getters.get_segments_timbre(h5)[0:20].flatten()
            ## Each segment contains info on 12 pitch classes (C, C#, D to B)
            self.segments_pitches = hdf5_getters.get_segments_timbre(h5)[0:20].flatten()
            ## Segment intensity points
            self.segments_loudness_max = hdf5_getters.get_segments_loudness_max(h5)[0:20].flatten()
            ## Beats
            self.beats_start = hdf5_getters.get_beats_start(h5)
            self.beats_duration = np.diff(self.beats_start)[0:20]
            self.beats_average_period = np.mean(self.beats_duration)
