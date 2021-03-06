type Relu <: Layer; y; Relu()=new() end
# copy(l::Relu; o...)=Relu()

forw(l::Relu,x; o...)=(l.y = reluforw(x))
back(l::Relu,dy; returndx=true, o...)=(returndx && reluback(l.y, reshape(dy, size(l.y))))

reluforw(x)=(x0=zero(eltype(x)); for i=1:length(x); (x[i]<x0)&&(x[i]=x0) end; x)
reluback(y, dy)=(y0=zero(eltype(dy)); for i=1:length(dy); (y[i]==y0)&&(dy[i]=y0) end; dy)

if GPU
forw(l::Relu,x::AbstractCudaArray; o...)=(l.y=cudnnActivationForward(x; mode=CUDNN_ACTIVATION_RELU))
back(l::Relu,dy::AbstractCudaArray; returndx=true, o...)=(@assert issimilar(dy, l.y); returndx && cudnnActivationBackward(l.y, dy; mode=CUDNN_ACTIVATION_RELU); dy)
end # if GPU
