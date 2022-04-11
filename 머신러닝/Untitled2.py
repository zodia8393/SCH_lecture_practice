#!/usr/bin/env python
# coding: utf-8

# In[3]:


#2022-04-11 머신러닝 9회차
#데이터 불러오기
from sklearn import datasets
digit_dataset=datasets.load_digits()
digit_dataset.keys()


# In[4]:


digit_dataset["images"].shape


# In[5]:


digit_dataset["target"][0]


# In[6]:


digit_dataset["images"][0]


# In[18]:


import matplotlib.pyplot as plt
from random import randint
_, axes = plt.subplots(nrows=1,ncols=4,figsize=(10,3))

for ax in axes:
    num=randint(1,1000)
    image=digit_dataset["images"][num]
    labe=digit_dataset["target"][num]
    ax.set_axis_off()
    ax.imshow(image,cmap=plt.cm.gray_r,interpolation='nearest')
    ax.set_title('Training: %i'%label)


# In[19]:


digit_dataset["data"][0].shape


# In[21]:


#데이터 분류하기
from sklearn.model_selection import train_test_split
X=digit_dataset["data"]
y=digit_dataset["target"]
X_train,X_test,y_train,y_test=train_test_split(X,y)


# In[36]:


from sklearn.linear_model import LogisticRegression

#max_iter를 지정해주지 않으면 수렴할때까지 코드가 실행되기 때문에 한계치를 지정해준다
logreg_ovr = LogisticRegression(multi_class="ovr",max_iter=1000) 
logreg_softmax = LogisticRegression(multi_class="multinomial",solver="sag",max_iter=1000)

logreg_ovr.fit(X_train, y_train)
logreg_softmax.fit(X_train, y_train)


# In[37]:


#성능 측정하기
from sklearn.metrics import confusion_matrix
y_pred=logreg_ovr.predict(X_test).copy()
y_true=y_test.copy()
confusion_matrix(y_true,y_pred)


# In[38]:


from sklearn.metrics import classification_report
print(classification_report(y_true,y_pred))


# In[39]:


result=confusion_matrix(y_true,y_pred)
result.diagonal().sum()/result.sum(axis=0).sum()


# In[40]:


from sklearn.metrics import precision_score
precision_score(y_true,y_pred,average="micro")


# In[41]:


precision_score(y_true,y_pred,average="macro")


# In[42]:


precision_score(y_true,y_pred,average=None)


# In[33]:


#ROC커브와 AUC 사이킷런 코드로 구현
import numpy as np
from sklearn import metrics

y=np.array([1,1,2,2])
scores=np.array([0.1,0.4,0.35,0.8])
fpr,tpr,thresholds=metrics.roc_curve(y,scores,pos_label=2)

# fpr - array([0. , 0. , 0.5, 0.5, 1. ])
# tpr - array([0. , 0.5, 0.5, 1. , 1. ])
# thresholds - array([1.8 , 0.8 , 0.4 , 0.35, 0.1 ])


# In[43]:


y=np.array([1,1,2,2])
pred=np.array([0.1,0.4,0.35,0.8])
fpr,tpr,threshholds=metrics.roc_curve(y,pred,pos_label=2)
roc_auc=metrics.auc(fpr,tpr)
roc_auc


# In[44]:


import matplotlib.pyplot as plt

plt.figure()
lw=2
plt.plot(fpr,tpr,lw=lw,label="ROC curve (area =%0.2f)"%roc_auc)
plt.plot([0,1],[0,1],color='navy',lw=lw,linestyle='--')
plt.xlim([0.0,1.0])
plt.ylim([0.0,1.05])
plt.xlabel('False Positive Rate')
plt.ylabel('True Positive Rate')
plt.title('Receiver operating characteristic example')
plt.legend(loc='lower right')
plt.show()


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




