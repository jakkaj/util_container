# A Util Container  
With stuff in it to help things when debugging your stuff-ups in cluster. 

Start:
```
kubectl run -i -t jordoutils --image=jakkaj/jordoutils:latest --restart=Never -- bash
```

Resume:

```
kubectl exec -it jordoutils -- bash
```
