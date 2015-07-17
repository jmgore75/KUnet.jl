try success(`nvcc --version`)
    cd("../src") do
        run(`make libkunet`)
    end
catch
    warn("CUDA not installed, GPU support will not be available.")
end
