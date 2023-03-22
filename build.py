import subprocess


def build():
    subprocess.run(["./gen_proto.sh"], check=True)


if __name__ == "__main__":
    build()
