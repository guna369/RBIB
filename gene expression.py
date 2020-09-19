get_gene_expression("PAX6","Homo Sapiens","dev_human_microarray_expression").head()
first
!pip install allensdk
from IPython.display import clear_output
clear_output()
 
Utility functions
from allensdk.api.queries.image_download_api import ImageDownloadApi
from allensdk.api.queries.svg_api import SvgApi
from allensdk.api.queries.ontologies_api import OntologiesApi
from allensdk.api.queries.grid_data_api import GridDataApi
from allensdk.config.manifest import Manifest
from allensdk.core.structure_tree import StructureTree
import matplotlib.patches as mpatches
from allensdk.api.queries.rma_api import RmaApi
import matplotlib.pyplot as plt
from skimage.io import imread
import pandas as pd
import urllib.request, json 
from pandas.io.json import json_normalize
import xml.etree.ElementTree as ET
import numpy as np
import requests, zipfile, io
import logging
import os
from base64 import b64encode
from IPython.display import HTML, display
from matplotlib import animation, rc
from IPython.display import HTML
 
#plt.rcParams['figure.dpi']= 300
 
image_api = ImageDownloadApi()
svg_api = SvgApi()
oapi = OntologiesApi()
rma = RmaApi()
def get_probe_ids(gene_str):
  gene_filter = "gene[acronym$eq" + gene_str + "]"
  criteria = "[probe_type$eqDNA]," + gene_filter
  return pd.DataFrame(rma.model_query('Probe',criteria=criteria,num_rows='all'))['id']
 
 
def get_gene_id(gene_str,organism):
  # e.g. rma.service_query('dev_human_expression',[("set","rna_seq_genes"),("probes","1090294")])
  # pd.DataFrame(rma.model_query('Gene',criteria="[acronym$eqPAX6],[type$eqEnsemblGene],organism[name$eq'Homo Sapiens']",num_rows='all'))['id']
 
  gene_filter = "[acronym$eq" + gene_str + "]"
  organism_filter = "organism[name$eq" + "'" + organism + "'" + "]" 
  criteria = gene_filter + ",[type$eqEnsemblGene]," + organism_filter
  gene_id = pd.DataFrame(rma.model_query('Gene',criteria=criteria,num_rows='all'))['id'].loc[0]
  return str(gene_id)
  
 
 
def get_gene_expression(gene_str,organism,dataset):
  ''' 
  gene_str: Gene acronym. Note that acronym for same gene may be different for mouse vs human. e.g. PAX6 vs. Pax6
  organism one of [Homo Sapiens, Mus musculus]
  dataset one of [dev_human_expression, dev_human_microarray_expression, dev_mouse_ish]
  '''
  exp = []
  if(organism == 'Homo Sapiens'):
    if(dataset=="dev_human_expression"):
        gene_id = get_gene_id(gene_str,organism)
        result = rma.service_query(dataset,[("set","rna_seq_genes"),("probes",gene_id)])
 
    elif(dataset == "dev_human_microarray_expression"):
        probe_ids = get_probe_ids(gene_str).astype(str).tolist()
        result = rma.service_query(dataset,[("probes",probe_ids)])
        
    exp = json_normalize(result['probes'],'z-score',['id','name','gene-symbol','gene-name','gene-id'])
    exp.rename(columns = {0:'z-score'}, inplace = True)
    exp['z-score'] = exp['z-score'].apply(pd.to_numeric)
        
    donors = json_normalize(result['samples'])
    exp = pd.concat([exp,donors],1)
    
    return exp
    
    # TODO: Add Mouse and NHP functions. Add age parameter. 
    
   
  
def find_section(df,section_num):
  mid_section = df.iloc[(df['section_number']-section_num).abs().argsort()][:1]
  return mid_section['id'].item() 
 
 
 
def download_section(section_id,section_image_directory):
  section_images = image_api.section_image_query(section_id)
  section_image_ids = [si['id'] for si in section_images]
 
  logging.getLogger('allensdk.api.api.retrieve_file_over_http').disabled = True
 
  for section_image_id in section_image_ids:
 
      file_name = str(section_image_id) + format_str
      file_path = os.path.join(section_image_directory, file_name)
 
      Manifest.safe_make_parent_dirs(file_path)
      image_api.download_section_image(section_image_id, file_path=file_path, downsample=downsample)
 
  logging.getLogger('allensdk.api.api.retrieve_file_over_http').disabled = False
Atlases
# TOOO: Work out how to improve resolution.  
 
pcw15_atlas_id = 138322603
pcw21_atlas_id = 3
yr34_atlas_id = 138322605
 
pcw15_atlas_records = image_api.atlas_image_query(pcw15_atlas_id)
pcw21_atlas_records = image_api.atlas_image_query(pcw21_atlas_id)
yr34_atlas_records = image_api.atlas_image_query(yr34_atlas_id)
 
pcw15_atlas_section_id = find_section(pd.DataFrame(pcw15_atlas_records),600)
pcw21_atlas_section_id = find_section(pd.DataFrame(pcw21_atlas_records),1500)
yr34_atlas_section_id = find_section(pd.DataFrame(yr34_atlas_records),1400)
 
file_path = 'annotation.jpg'
image_api.download_atlas_image(pcw15_atlas_section_id, "15pcw_atlas.jpg", annotation=True, downsample=4)
image_api.download_atlas_image(pcw21_atlas_section_id, "21pcw_atlas.jpg", annotation=True, downsample=4)
image_api.download_atlas_image(yr34_atlas_section_id, "34yr_atlas.jpg", annotation=True, downsample=4)
 
fig, ax = plt.subplots(ncols=3, figsize=(20, 44))
pcw15_image = imread("15pcw_atlas.jpg")
pcw21_image = imread("21pcw_atlas.jpg")
yr34_image = imread("34yr_atlas.jpg")
 
ax[0].imshow(pcw15_image)
ax[1].imshow(pcw21_image)
ax[2].imshow(yr34_image)

Neurogenesis
# TODO: Add if statement to prevent downloading dataset if already downloaded. Make more general so can be applied to any genes/age. 
 
pax6_section_id = 100143447
#pax6_image_id = 102187868
 
tbr2_section_id = 100142338
#tbr2_image_id = 102166887
 
tbr1_section_id = 100142262
 
 
downsample = 5
format_str = '.jpg'
 
pax6_records = image_api.section_image_query(pax6_section_id)
tbr2_records = image_api.section_image_query(tbr2_section_id)
tbr1_records = image_api.section_image_query(tbr1_section_id)
 
pax6_image_id = find_section(pd.DataFrame(pax6_records),600)
tbr2_image_id = find_section(pd.DataFrame(tbr2_records),600)
tbr1_image_id = find_section(pd.DataFrame(tbr1_records),600)
 
download_section(pax6_section_id,"pax6")
download_section(tbr2_section_id,"tbr2")
download_section(tbr1_section_id,"tbr1")
 
pax6_file_path = os.path.join("pax6",str(pax6_image_id) + format_str)
tbr2_file_path = os.path.join("tbr2",str(tbr2_image_id) + format_str)
tbr1_file_path = os.path.join("tbr1",str(tbr1_image_id) + format_str)
 
fig, ax = plt.subplots(ncols=3, figsize=(16, 16))
pax6_image = imread(pax6_file_path)
tbr2_image = imread(tbr2_file_path)
tbr1_image = imread(tbr1_file_path)
 
ax[0].imshow(pax6_image)
ax[0].set_title("Pax6 Expression")
ax[1].imshow(tbr2_image)
ax[1].set_title("Tbr2 Expression")
ax[2].imshow(tbr1_image)
ax[2].set_title("Tbr1 Expression")
 
 TODO: Could compare inner vs. outer VZ to see if that lows tbr2 expression
 
pax6_exp = get_gene_expression("PAX6","Homo Sapiens","dev_human_microarray_expression")
tbr2_exp = get_gene_expression("EOMES","Homo Sapiens","dev_human_microarray_expression")
tbr1_exp = get_gene_expression("TBR1","Homo Sapiens","dev_human_microarray_expression")
 
vz_pax6 = pax6_exp[pax6_exp['top_level_structure.abbreviation'] == 'VZ']
vz_tbr2 = tbr2_exp[tbr2_exp['top_level_structure.abbreviation'] == 'VZ']
vz_tbr1 = tbr1_exp[tbr1_exp['top_level_structure.abbreviation'] == 'VZ']
 
sz_pax6 = pax6_exp[pax6_exp['top_level_structure.abbreviation'] == 'SZ']
sz_tbr2 = tbr2_exp[tbr2_exp['top_level_structure.abbreviation'] == 'SZ']
sz_tbr1 = tbr1_exp[tbr1_exp['top_level_structure.abbreviation'] == 'SZ']
 
cp_tbr1 = tbr1_exp[tbr1_exp['top_level_structure.abbreviation'] == 'CP']
cp_tbr2 = tbr2_exp[tbr2_exp['top_level_structure.abbreviation'] == 'CP']
cp_pax6 = pax6_exp[pax6_exp['top_level_structure.abbreviation'] == 'CP']
 
 
bins = np.linspace(0, 3, 20)
 
fig, ax = plt.subplots(ncols=3, figsize=(18, 8))
 
ax[0].hist(vz_pax6['z-score'],bins,alpha=0.5,label='PAX6',color='b')
ax[0].hist(vz_tbr2['z-score'],bins,alpha=0.5,label='TBR2',color='g')
ax[0].hist(vz_tbr1['z-score'],bins,alpha=0.5,label='TBR1',color='r')
ax[0].legend(loc='upper right')
ax[0].set_title("Pax6/TBR2/TBR1 expression in VZ")
 
ax[1].hist(sz_pax6['z-score'],bins,alpha=0.5,label='PAX6',color='b')
ax[1].hist(sz_tbr2['z-score'],bins,alpha=0.5,label='TBR2',color='g')
ax[1].hist(sz_tbr1['z-score'],bins,alpha=0.5,label='TBR1',color='r')
ax[1].legend(loc='upper right')
ax[1].set_title("Pax6/TBR2/TBR1 expression in SZ")
 
ax[2].hist(cp_pax6['z-score'],bins,alpha=0.5,label='PAX6',color='b')
ax[2].hist(cp_tbr2['z-score'],bins,alpha=0.5,label='TBR2',color='g')
ax[2].hist(cp_tbr1['z-score'],bins,alpha=0.5,label='TBR1',color='r')
ax[2].legend(loc='upper right')
ax[2].set_title("Pax6/TBR2/TBR1 expression in CP")
 
 
Cortical Arealization
# 2D plot of lateral-medial and anterior-posterior with heat map of arealisation gene expression 
# need to relate structure to lateral-medial/anterior-posterior coordinates.
 
def get_grid_exp(gene,age):
  from allensdk.api.queries.rma_api import RmaApi
  rma = RmaApi()
  associations = ''.join(['products[abbreviation$eqDevMouse],', 'genes[acronym$eq',gene,'],specimen(donor(age[days$eq',str(age),']))'])
  section_set_ids = pd.DataFrame(rma.model_query('SectionDataSet',include=associations,criteria=associations,num_rows=5))['id']
 
  exp_grid_url = "http://api.brain-map.org/grid_data/download/" + str(section_set_ids.loc[0])
  r = requests.get(exp_grid_url)
  z = zipfile.ZipFile(io.BytesIO(r.content))
  z.extractall()
 
  exp_grid = imread('energy.mhd', plugin='simpleitk')
  return exp_grid
  
slice11 = 75
slice13 = 131
slice15 = 150
 
def get_grid_coords(age_str):
  '''
  Downloads annotation volume with 3D coordinates annotating structures of mouse brain.
  age_str: [E11pt5,E13pt5,E15pt5,E16pt5,E18pt5,P4,P14,P28,P56]
  Coordinates are in form (left-right ,superior inferior, anterior-posterior)
  '''
  annot_url = "http://download.alleninstitute.org/informatics-archive/current-release/mouse_annotation/" + age_str + "_DevMouse2012_annotation.zip"
 
  r = requests.get(annot_url)
  z = zipfile.ZipFile(io.BytesIO(r.content))
  z.extractall()
 
  coords = imread('annotation.mhd', plugin='simpleitk')
  return coords
 
def colours_to_cmaps(colours):
  cmaps = []
  for i in range(len(colours)):
    cmaps.append(colours[i].capitalize() + "s")
  return cmaps
  
def compare_2d_expression(gene1,gene2,coords,age,ax,colours=['red','blue'],title=""):
  # TODO: change gene slice index depending on age
  # Find out how P56 etc. is specified in days
 
  gene1_grid = get_grid_exp(gene1,age)
  gene2_grid = get_grid_exp(gene2,age)
 
  gene1_slice = gene1_grid[25,:,:]
  gene2_slice = gene2_grid[25,:,:]
  
  gene1_slice[gene1_slice < 0.25] = 0
  gene2_slice[gene2_slice < 0.25] = 0
 
  extent = 0, 350, 0, 350
  cmaps = colours_to_cmaps(colours)
 
  ax.imshow(coords,alpha=0.6,cmap='gray',interpolation='nearest',extent=extent)
  ax.imshow(gene1_slice,alpha=0.8,cmap=cmaps[0],interpolation='bilinear',extent=extent)
  ax.imshow(gene2_slice,alpha=0.5,cmap=cmaps[1],interpolation='bilinear',extent=extent)
 
  red_patch = mpatches.Patch(color=colours[0], label=gene1)
  blue_patch = mpatches.Patch(color=colours[1], label=gene2)
 
  ax.set_title(title)
  ax.legend(handles=[red_patch,blue_patch],loc=2)
 
def gene_exp_animation(gene,age,colour=['red']):
  age_to_text = {11.5:"E11pt5", 13.5:"E13pt5",15.5:"E15pt5"}
  age_to_slice = {11.5:slice11,13.5:slice13,15.5:slice15}
 
  gene1_grid = get_grid_exp(gene,age)
  num_frames = len(gene1_grid[:,0,0])
 
  coords = get_grid_coords(age_to_text[age])
  coords[coords!=0] = 1
  coords = coords[age_to_slice[age],:,:]
 
  fig, ax = plt.subplots(ncols=1, figsize=(10, 6))
  extent = 0, 350, 0, 350
 
  gene1_slice = gene1_grid[25,:,:]
  gene1_slice[gene1_slice < 0.25] = 0
 
  cmap = colours_to_cmaps(colour)[0]
 
  backg = ax.imshow(coords,alpha=0.6,cmap='gray',interpolation='nearest',extent=extent)
  im = ax.imshow(gene1_slice,alpha=0.8,cmap=cmap,interpolation='bilinear',extent=extent)
 
  patch = mpatches.Patch(color=colour[0], label=gene)
 
  ax.set_title("")
  ax.legend(handles=[patch],loc=2)   
  plt.close()
 
  def animate(i):
 
    gene1_slice = gene1_grid[i,:,:]
    gene1_slice[gene1_slice < 0.25] = 0
    im.set_array(gene1_slice)
 
    return im,
 
  ani = animation.FuncAnimation(fig, animate, interval=1, frames=num_frames, blit=True)
  rc('animation', html='jshtml')
  return ani
 
gene_exp_animation("Nr2f1",13.5,colour=['blue'])
#exp_ani.save("exp_ani.mp4",fps=10)
coords = get_grid_coords("E13pt5")
coords[coords!=0] = 1
brainmap = coords[slice13,:,:]
 
fig, ax = plt.subplots(ncols=2, figsize=(18, 8))
compare_2d_expression("Sp8","Nr2f1",brainmap,13.5,ax[0],['red','blue'])
compare_2d_expression("Pax6","Emx2",brainmap,13.5,ax[1],['purple','green'])
 
coords11 = get_grid_coords("E11pt5")
coords13 = get_grid_coords("E13pt5")
coords15 = get_grid_coords("E15pt5")
 
coords11[coords11!=0] = 1
coords13[coords13!=0] = 1
coords15[coords15!=0] = 1
 
brainmap11 = coords11[slice11,:,:]
brainmap13 = coords13[slice13,:,:]
brainmap15 = coords15[slice15,:,:]
 
fig, ax = plt.subplots(ncols=3, figsize=(18, 8))
compare_2d_expression("Sp8","Nr2f1",brainmap11,11.5,ax[0],title="E11.5")
compare_2d_expression("Sp8","Nr2f1",brainmap13,13.5,ax[1],title="E13.5")
compare_2d_expression("Sp8","Nr2f1",brainmap15,15.5,ax[2],title="E15.5")
fig, ax = plt.subplots(ncols=3, figsize=(18, 8))
compare_2d_expression("Pax6","Emx2",brainmap11,11.5,ax[0],['purple','green'],title="E11.5")
compare_2d_expression("Pax6","Emx2",brainmap13,13.5,ax[1],['purple','green'],title="E13.5")
compare_2d_expression("Pax6","Emx2",brainmap15,15.5,ax[2],['purple','green'],title="E15.5")
